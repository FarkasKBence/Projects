LINK = "https://dnd5e.wikidot.com/spells:cleric"
OUTPUT_FILE = "cleric_spells.json"

from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import json

def get_spell_info(driver, link):
    driver.get(link)

    spell_content = driver.find_element(By.CLASS_NAME, "main-content-wrap")
    name = spell_content.find_element(By.CLASS_NAME, "page-title").text.strip();

    details = spell_content.find_elements(By.TAG_NAME, "p")
    # source, type, level, casting time, range, components, duration, description, classes
    spell_dict = {"name": name}
    spell_dict["source"] = details[0].text.strip("Source: ")
    spell_dict["type"] = details[1].text.strip()
    spell_info = details[2].text.splitlines()
    spell_dict["casting_time"] = spell_info[0].removeprefix("Casting Time: ")
    spell_dict["range"] = spell_info[1].removeprefix("Range: ")
    spell_dict["components"] = spell_info[2].removeprefix("Components: ")
    spell_dict["duration"] = spell_info[3].removeprefix("Duration: ")
    desc_text = ""
    for i in range(3, len(details) - 1):
        desc_text += details[i].text.strip() + "\n"
    spell_dict["description"] = desc_text.strip()

    return spell_dict

# Set up Firefox options (optional)
options = webdriver.FirefoxOptions()
options.add_argument("--headless")  # Run in headless mode (optional)
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

main_driver = webdriver.Firefox(options=options)
spell_driver = webdriver.Firefox(options=options)

main_driver.get(LINK)
time.sleep(1)

json_data = None
python_data = []

content = main_driver.find_element(By.ID, "page-content")
if content:
    navbar = content.find_element(By.CLASS_NAME, "yui-nav")
    if navbar:
        for page in navbar.find_elements(By.TAG_NAME, "a"):
            page.click();
            page_content = main_driver.find_element(By.CLASS_NAME, "yui-content")
            links = page_content.find_elements(By.TAG_NAME, "a")
            for sub_link in links:
                stripped_link = sub_link.text.strip()
                if stripped_link != "":
                    spell_info = get_spell_info(spell_driver, sub_link.get_attribute("href"))
                    python_data.append(spell_info)
    else:
        print("Navbar returned None.")
else:
    print("Content returned None.")

json_data = json.dumps(python_data, indent=4, ensure_ascii=False)
#print(json_data)

time.sleep(1)
spell_driver.quit()
main_driver.quit()

json_file = open(OUTPUT_FILE, "w")
json_file.write(json_data)
json_file.close()