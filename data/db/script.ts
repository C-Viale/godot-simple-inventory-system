type ItemData = {
  id: string;
  name: string;
  description: string;
  icon_path: string;
  category: ItemCategory;
  tradeable: boolean;
};

type WeaponData = ItemData & {
  weapon_type: string;
  damage: number;
};

enum ItemCategory {
  RESOURCE, // 0
  CONSUMABLE, //1,
  KEY, // 2
  RECIPE, // 3
  WEAPON, // 4
  OFFHAND, // 5
  TOOL, // 6
  ARMOR, //7
}

const WeaponType = {
  SWORD: 0,
  AXE: 1,
  HAMMER: 2,
  BOW: 3,
};

console.log(WeaponType);

async function main() {
  const items: ItemData[] = [];
  items.concat(...(await parseWeapons()));
  // items.concat(parseEquipments())
  // items.concat(parseItems())

  // console.log(items);
}

async function readFile(path: string): Promise<string[]> {
  const file = Bun.file(path);
  return (await file.text()).split("\n");
}

async function parseWeapons(): Promise<ItemData[]> {
  const lines = await readFile("./weapons.txt");
  const result: ItemData[] = [];

  for (const line of lines) {
    const data = line.split(";").map((e) => e.trim());
    const i: WeaponData = {
      id: data[0],
      name: data[3],
      description: data[4],
      icon_path: data[5],
      category: ItemCategory.WEAPON,
      tradeable: false,
      weapon_type: WeaponType[data[1]],
      damage: Number(data[2]),
    };

    result.push(i);
  }

  console.log(result);

  return result;
}

await main();
