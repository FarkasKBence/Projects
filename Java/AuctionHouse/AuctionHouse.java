import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;
import java.util.stream.IntStream;

public class AuctionHouse {
	static class NFT {
		public final int artistIdx;
		public final int price;

		public NFT(int artistIdx, int price) {
			this.artistIdx = artistIdx;
			this.price = price;
		}
	}

	static class AuctionOffer {
		public int offeredSum;
		public String collectorName;

		public AuctionOffer(int offeredSum, String collectorName) {
			this.offeredSum = offeredSum;
			this.collectorName = collectorName;
		}
	}

	static int failCount = 0;

	static final int MAX_NFT_PRICE = 100;
	static final int MAX_NFT_IDX = 100_000;
	static final int MAX_COLLECTOR_OFFER = MAX_NFT_IDX / 100;

	private static final int COLLECTOR_MIN_SLEEP = 10;
	private static final int COLLECTOR_MAX_SLEEP = 20;
	private static final int MAX_AUCTION_OFFERS = 10;

	static final int ARTIST_COUNT = 10;
	static final int COLLECTOR_COUNT = 5;

	static final int INIT_ASSETS = MAX_NFT_IDX / 10 * MAX_NFT_PRICE;

	static int nftIdx = 0;
	static int remainingNftPrice = INIT_ASSETS;
	static NFT[] nfts = new NFT[MAX_NFT_IDX];

	static int totalCommission = 0;
	static int noAuctionAvailableCount = 0;
	static int soldItemCount = 0;

	static Set<String> owners = new ConcurrentSkipListSet<>();

	static BlockingQueue<AuctionOffer> auctionQueue = null;


	public static void main(String[] args) throws InterruptedException {
		List<Thread> artists = makeArtists();
		Thread auctioneer = makeAuctioneer(artists);
		List<Thread> collectors = makeCollectors(auctioneer);

		for (var artist: artists) {
			artist.start();
		}
		auctioneer.start();
		for (var collector: collectors) {
			collector.start();
		}

		for (var artist: artists) {
			artist.join();
		}
		auctioneer.join();
		for (var collector: collectors) {
			collector.join();
		}

		runChecks();
	}

	private static List<Thread> makeCollectors(Thread auctioneer) {
		List<Thread> retval = new ArrayList<>();
		for (int i = 0; i < COLLECTOR_COUNT; i++) {
			var collectorIdx = i;
			Thread collector = new Thread(() -> {
				BlockingQueue<AuctionOffer> prevAuctionQueue = null;

				while (true) {
					if (!auctioneer.isAlive())   break;

					sleepForMsec(getRandomBetween(COLLECTOR_MIN_SLEEP, COLLECTOR_MAX_SLEEP, true));

					boolean isAuctionOn;
					synchronized (AuctionHouse.class) {
						isAuctionOn = auctionQueue != null;
						if (!isAuctionOn) {
							++noAuctionAvailableCount;
							continue;
						}

						if (prevAuctionQueue == auctionQueue) {
							isAuctionOn = false;
						} else {
							auctionQueue.offer(new AuctionOffer(getRandomBetween(1, MAX_COLLECTOR_OFFER, true), "Collector" + collectorIdx));
							prevAuctionQueue = auctionQueue;
						}
					}
				}

				System.out.println("Collector " + collectorIdx + " done");
			});
			retval.add(collector);
		}
		return retval;
	}

	private static int getRandomBetween(int min, int max, boolean isMaxIncluded) {
		return ThreadLocalRandom.current().nextInt(min, max + (isMaxIncluded ? 1 : 0));
	}

	private static Thread makeAuctioneer(List<Thread> artists) {
		Thread auctioneer = new Thread(() -> {
			int remainingAuctionCount = 100;

			while (true) {
				boolean areArtistsWorking = false;
				for (Thread artist : artists) {
					areArtistsWorking |= artist.isAlive();
				}
				if (!areArtistsWorking && remainingAuctionCount <= 0)   break;

				int availableNftCount;
				synchronized (AuctionHouse.class) {
					availableNftCount = nftIdx;
				}

				if (availableNftCount == 0)  continue;

				var chosenNftIdx = getRandomBetween(0, availableNftCount, false);

				synchronized (AuctionHouse.class) {
					auctionQueue = new ArrayBlockingQueue<>(100);
				}

				int bestPrice = 0;
				String bestCollector = null;

				for (int i = 0; i < MAX_AUCTION_OFFERS; i++) {
					try {
						AuctionOffer offer = auctionQueue.poll(1, TimeUnit.MILLISECONDS);
						if (offer != null) {
							if (offer.offeredSum > bestPrice) {
								bestPrice = offer.offeredSum;
								bestCollector = offer.collectorName;
							}
						}
					} catch (InterruptedException e) {
						break;
					}

					if (bestPrice != 0) {
//						System.out.printf("Got best offer %d from %s%n", bestPrice, bestCollector);
						++soldItemCount;
						owners.add(bestCollector);
					}

					totalCommission += (nfts[chosenNftIdx].price + bestPrice) / 10;
				}

				synchronized (AuctionHouse.class) {
					auctionQueue = null;
				}

				sleepForMsec(3);
				--remainingAuctionCount;
			}

			System.out.println("Auctioneer done");
		});
		return auctioneer;
	}

	private static List<Thread> makeArtists() {
		List<Thread> retval = new ArrayList<>();
		for (int i = 0; i < ARTIST_COUNT; i++) {
			var artistIdx = i;
			Thread artist = new Thread(() -> {
				while (true) {
					sleepForMsec(20);

					var nftPrice = getRandomBetween(100, 1000, true);

					int currNftIdx;
					synchronized (AuctionHouse.class) {
						if (nftIdx > MAX_NFT_IDX)   break;
						if (nftPrice > remainingNftPrice)   break;
						currNftIdx = nftIdx;
						remainingNftPrice -= nftPrice;
						++nftIdx;
					}

					nfts[currNftIdx] = new NFT(artistIdx, nftPrice);
				}

				System.out.println("Artist " + artistIdx + " done");
			});
			retval.add(artist);
		}
		return retval;
	}

	private static String isOK(boolean condition) {
		if (!condition)   ++failCount;
		return isOkTxt(condition);
	}

	private static String isOkTxt(boolean condition) {
		return condition ? "GOOD" : "BAD ";
	}

	private static void runChecks() {
		if (Thread.activeCount() == 1) {
			System.out.printf("%s Only the current thread is running%n", isOK(true));
		} else {
			System.out.printf("%s %d threads are active, there should be only one%n", isOK(Thread.activeCount() == 1), Thread.activeCount());
		}

		System.out.printf("%s nftIdx > 0%n", isOK(nftIdx > 0));

		int soldPrice = IntStream.range(0, nftIdx).map(idx-> nfts[idx].price).sum();
		System.out.printf("%s Money is not lost: %d + %d = %d%n", isOK(soldPrice + remainingNftPrice == INIT_ASSETS), soldPrice, remainingNftPrice, INIT_ASSETS);

		System.out.printf("%s [Only Task 2] Total commission not zero: %d > 0%n", isOK(totalCommission > 0), totalCommission, INIT_ASSETS);

		System.out.printf("%s [Only Task 3] Sold item count not zero: %d > 0%n", isOK(soldItemCount > 0), soldItemCount, INIT_ASSETS);
		System.out.printf("%s [Only Task 3] Some collectors have become owners of NFTs: %d > 0%n", isOK(owners.size() > 0), owners.size(), INIT_ASSETS);
		System.out.printf("%s [Only Task 3] Sometimes, collectors found no auction: %d > 0%n", isOK(noAuctionAvailableCount > 0), noAuctionAvailableCount, INIT_ASSETS);

		System.out.printf("%s Altogether %d condition%s failed%n", isOkTxt(failCount == 0), failCount, failCount == 1 ? "" : "s");

		// forcibly shutting down the program (don't YOU ever do this)
		System.exit(42);
	}

	private static void sleepForMsec(int msec) {
		try {
			Thread.sleep(msec);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
