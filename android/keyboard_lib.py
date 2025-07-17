import xml.etree.ElementTree as ET
from xml.dom import minidom
import subprocess

DIRECTIONS = ("C", "N", "E", "W", "S", "NE", "NW", "SE", "SW",)
keyboard = ET.Element("keyboard")

def generate_key(*directions, **attributes):
    direction_attributes = dict(zip(DIRECTIONS, directions))
    return ET.Element("key", attrib={**direction_attributes, **attributes})

def generate_row(keys, **attributes):
    row = ET.Element("row", attrib=attributes)
    row.extend(map(generate_key, keys))
    return row

def add_modifier(on, **modifiers):
    modmap = keyboard.find("modmap")
    if modmap is None:
        modmap = ET.Element("modmap")
        keyboard.insert(0, modmap)

    for modifier, modified in modifiers.items():
        modmap.append(ET.Element(modifier, attrib={"a": on, "b": modified}))

def update_key(on, **attributes):
    _, key_element = get_row_and_key_element(on)
    key_element.attrib.update(attributes)

def update_row(on, **attributes):
    row_element, _ = get_row_and_key_element(on)
    row_element.attrib.update(attributes)

def get_row_and_key_element(on):
    for row_element in keyboard.iter("row"):
        for key_element in row_element.iter("key"):
            if on in key_element.attrib.values():
                return row_element, key_element

    raise ValueError(f"Key {on} not found in keyboard layout")

def insert_relative(on, offset=0, **attributes):
    row_element, key_element = get_row_and_key_element(on)
    index = list(row_element).index(key_element)
    row_element.insert(index + offset, generate_key(**attributes))

def insert_before(on, **attributes):
    insert_relative(on, offset=0, **attributes)

def insert_after(on, **attributes):
    insert_relative(on, offset=1, **attributes)

def clean():
    for element in keyboard.iter():
        element.attrib = {k.lower(): str(v)
            for k, v in element.attrib.items()
            if v is not None
        }
    return keyboard

def update_keyboard(*rows, **attributes):
    keyboard.extend(map(generate_row, rows))
    keyboard.attrib.update(attributes)

def pretty_xml():
    clean()
    rough_string = ET.tostring(keyboard, encoding='utf-8')
    parsed = minidom.parseString(rough_string)
    return parsed.toprettyxml(indent="  ", encoding="utf-8").decode("utf-8")

def pretty_print():
    print(pretty_xml())

def pretty_copy():
    subprocess.run(["termux-clipboard-set"], input=pretty_xml().encode("utf-8"))
