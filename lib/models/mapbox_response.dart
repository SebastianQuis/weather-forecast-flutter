
import 'dart:convert';

class MapBoxResponse {
    final String type;
    final List<Feature> features;
    final String attribution;

    MapBoxResponse({
        required this.type,
        required this.features,
        required this.attribution,
    });

    factory MapBoxResponse.fromRawJson(String str) => MapBoxResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MapBoxResponse.fromJson(Map<String, dynamic> json) => MapBoxResponse(
        type: json["type"],
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

class Feature {
    final String id;
    final String type;
    final List<String> placeType;
    final Properties properties;
    final String textEs;
    final String? languageEs;
    final String placeNameEs;
    final String text;
    final String? language;
    final String placeName;
    final List<double> center;
    final Geometry geometry;
    final String? matchingPlaceName;

    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.properties,
        required this.textEs,
        this.languageEs,
        required this.placeNameEs,
        required this.text,
        this.language,
        required this.placeName,
        required this.center,
        required this.geometry,
        this.matchingPlaceName,
    });

    factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        languageEs: json["language_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        matchingPlaceName: json["matching_place_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toJson(),
        "text_es": textEs,
        "language_es": languageEs,
        "place_name_es": placeNameEs,
        "text": text,
        "language": language,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "matching_place_name": matchingPlaceName,
    };
}

class Context {
    final String id;
    final String mapboxId;
    final String textEs;
    final String text;
    final String? wikidata;
    final String? languageEs;
    final String? language;
    final String? shortCode;

    Context({
        required this.id,
        required this.mapboxId,
        required this.textEs,
        required this.text,
        this.wikidata,
        this.languageEs,
        this.language,
        this.shortCode,
    });

    factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"],
        languageEs: json["languageEs"],
        language: json["language"],
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mapbox_id": mapboxId,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        "language_es": languageEs,
        "language": language,
        "short_code": shortCode,
    };
}


class Geometry {
    final List<double> coordinates;
    final String type;

    Geometry({
        required this.coordinates,
        required this.type,
    });

    factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
    };
}

class Properties {
    final String? address;
    final String? foursquare;
    final String? wikidata;
    final bool? landmark;
    final String? category;
    final String? maki;
    final String? mapboxId;
    final String? accuracy;

    Properties({
        this.address,
        this.foursquare,
        this.wikidata,
        this.landmark,
        this.category,
        this.maki,
        this.mapboxId,
        this.accuracy,
    });

    factory Properties.fromRawJson(String str) => Properties.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        address: json["address"],
        foursquare: json["foursquare"],
        wikidata: json["wikidata"],
        landmark: json["landmark"],
        category: json["category"],
        maki: json["maki"],
        mapboxId: json["mapbox_id"],
        accuracy: json["accuracy"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "foursquare": foursquare,
        "wikidata": wikidata,
        "landmark": landmark,
        "category": category,
        "maki": maki,
        "mapbox_id": mapboxId,
        "accuracy": accuracy,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap!;
    }
}
