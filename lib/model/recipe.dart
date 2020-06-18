// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

class Recipe {
  Recipe({
    this.data,
    this.links,
    this.meta,
  });

  List<Data> data;
  Links links;
  Meta meta;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.title,
    this.servings,
    this.totalTime,
    this.prepTime,
    this.cookTime,
    this.imageUrl,
    this.sourceUrl,
    this.notes,
    this.createdAt,
    this.source,
    this.ingredients,
    this.directions,
  });

  String id;
  String title;
  int servings;
  int totalTime;
  dynamic prepTime;
  dynamic cookTime;
  String imageUrl;
  String sourceUrl;
  String notes;
  dynamic createdAt;
  Source source;
  List<Ingredient> ingredients;
  List<Direction> directions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        servings: json["servings"],
        totalTime: json["total_time"],
        prepTime: json["prep_time"],
        cookTime: json["cook_time"],
        imageUrl: json["image_url"],
        sourceUrl: json["source_url"],
        notes: json["notes"],
        createdAt: json["created_at"],
        source: Source.fromJson(json["source"]),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
        directions: List<Direction>.from(
            json["directions"].map((x) => Direction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "servings": servings,
        "total_time": totalTime,
        "prep_time": prepTime,
        "cook_time": cookTime,
        "image_url": imageUrl,
        "source_url": sourceUrl,
        "notes": notes,
        "created_at": createdAt,
        "source": source.toJson(),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "directions": List<dynamic>.from(directions.map((x) => x.toJson())),
      };
}

class Direction {
  Direction({
    this.step,
    this.text,
  });

  int step;
  String text;

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        step: json["step"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "step": step,
        "text": text,
      };
}

class Ingredient {
  Ingredient({
    this.id,
    this.name,
    this.description,
    this.preparation,
    this.quantity,
    this.displayQuantity,
    this.unit,
  });

  int id;
  String name;
  String description;
  String preparation;
  String quantity;
  String displayQuantity;
  Unit unit;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        preparation: json["preparation"] == null ? null : json["preparation"],
        quantity: json["quantity"],
        displayQuantity: json["display_quantity"],
        unit: Unit.fromJson(json["unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description == null ? null : description,
        "preparation": preparation == null ? null : preparation,
        "quantity": quantity,
        "display_quantity": displayQuantity,
        "unit": unit.toJson(),
      };
}

class Unit {
  Unit({
    this.id,
    this.name,
    this.abbreviation,
    this.namePlural,
    this.abbreviationPlural,
  });

  String id;
  String name;
  String abbreviation;
  String namePlural;
  String abbreviationPlural;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
        abbreviation: json["abbreviation"],
        namePlural: json["name_plural"],
        abbreviationPlural: json["abbreviation_plural"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "abbreviation": abbreviation,
        "name_plural": namePlural,
        "abbreviation_plural": abbreviationPlural,
      };
}

class Source {
  Source({
    this.name,
    this.siteUrl,
    this.imageUrl,
  });

  String name;
  String siteUrl;
  String imageUrl;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json["name"],
        siteUrl: json["site_url"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "site_url": siteUrl,
        "image_url": imageUrl,
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}
