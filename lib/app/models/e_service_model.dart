import 'package:get/get.dart';

import '../../common/uuid.dart';
import 'category_model.dart';
import 'e_provider_model.dart';
import 'media_model.dart';
import 'parents/model.dart';

class EService extends Model {
  String? id;
  String? name;
  String? description;
  List<Media>? images;
  double? price;
  String? pic;
  double? discountPrice;
  String? priceUnit;
  String? quantityUnit;
  double? rate;
  bool? available;
  int? totalReviews;
  String? duration;
  bool? featured;
  bool? enableBooking;
  bool? isFavorite;
  List<Category>? categories;
  List<Category>? subCategories;
  EProvider? eProvider;

  EService(
      {this.id,
        this.name,
        this.description,
        this.images,
        this.price,
        this.pic,
        this.discountPrice,
        this.priceUnit,
        this.quantityUnit,
        this.rate,
        this.totalReviews,
        this.duration,
        this.featured,
        this.enableBooking,
        this.isFavorite,
        this.categories,
        this.subCategories,
        this.available,
        this.eProvider});

  EService.fromJson(Map<String, dynamic>? json) {
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    price = doubleFromJson(json, 'price');
    pic = transStringFromJson(json, 'picture');
    discountPrice = doubleFromJson(json, 'discount_price');
    priceUnit = stringFromJson(json, 'price_unit');
    quantityUnit = transStringFromJson(json, 'quantity_unit');
    rate = doubleFromJson(json, 'rate');
    totalReviews = intFromJson(json, 'total_reviews');
    duration = stringFromJson(json, 'duration');
    featured = boolFromJson(json, 'featured');
    available = boolFromJson(json, 'available');
    enableBooking = boolFromJson(json, 'enable_booking');
    isFavorite = boolFromJson(json, 'is_favorite');
    categories = <Category>[];
    json!['categories']??[].forEach((v) {
      categories!.add(new Category.fromJson(v));
    });
    subCategories = <Category>[];
    json['sub_categories']??[].forEach((v) {
      subCategories!.add(new Category.fromJson(v));
    });
    eProvider = objectFromJson(json, 'e_provider', (value) => EProvider.fromJson(value));
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (name != null) data['name'] = this.name;
    if (this.description != null) data['description'] = this.description;
    if (pic != null) data['picture'] = this.pic;
    if (this.price != null) data['price'] = this.price;
    if (discountPrice != null) data['discount_price'] = this.discountPrice;
    if (priceUnit != null) data['price_unit'] = this.priceUnit;
    if (quantityUnit != null && quantityUnit != 'null') data['quantity_unit'] = this.quantityUnit;
    if (rate != null) data['rate'] = this.rate;
    if (totalReviews != null) data['total_reviews'] = this.totalReviews;
    if (duration != null) data['duration'] = this.duration;
    if (featured != null) data['featured'] = this.featured;
    if (enableBooking != null) data['enable_booking'] = this.enableBooking;
    if (isFavorite != null) data['is_favorite'] = this.isFavorite;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v?.id).toList();
    }
    if (this.images != null) {
      data['image'] = this.images!.where((element) => Uuid.isUuid(element.id!)).map((v) => v.id).toList();
    }
    if (this.subCategories != null) {
      data['sub_categories'] = this.subCategories!.map((v) => v.toJson()).toList();
    }
    if (this.eProvider != null && this.eProvider!.hasData) {
      data['e_provider_id'] = this.eProvider!.id;
    }
    return data;
  }

  String get firstImageUrl => this.images?.first.url ?? '';

  String get firstImageThumb => this.images?.first.thumb ?? '';

  String get firstImageIcon => this.images?.first.icon ?? '';

  @override
  bool get hasData {
    return id != null && name != null && description != null   && pic!= null  ;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double? get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice : price;
  }

  String get getUnit {
    if (priceUnit == 'fixed') {
      if (quantityUnit!.isNotEmpty) {
        return "/" + quantityUnit!.tr;
      } else {
        return "";
      }
    } else {
      return "/h".tr;
    }
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
          super == other &&
              other is EService &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              pic == other.pic &&
              description == other.description &&
              rate == other.rate &&
              isFavorite == other.isFavorite &&
              enableBooking == other.enableBooking &&
              categories == other.categories &&
              subCategories == other.subCategories &&
              available == other.available &&
              eProvider == other.eProvider;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      rate.hashCode ^
      eProvider.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      isFavorite.hashCode ^
      pic.hashCode ^
      available.hashCode ^
      enableBooking.hashCode;
}
