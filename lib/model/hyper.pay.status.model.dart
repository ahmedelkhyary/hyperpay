// To parse this JSON data, do
//
//     final hyperpayStatus = hyperpayStatusFromMap(jsonString);

import 'dart:convert';

const successCode = "000.100.110";

HyperpayStatus hyperpayStatusFromJson(String str) =>
    HyperpayStatus.fromJson(json.decode(str));

String hyperpayStatusToJson(HyperpayStatus data) => json.encode(data.toJson());

class HyperpayStatus {
  String? id;
  String? paymentType;
  String? paymentBrand;
  String? amount;
  String? currency;
  String? descriptor;
  Result? result;
  ResultDetails? resultDetails;
  VDCCard? card;
  Customer? customer;
  CustomParameters? customParameters;
  Risk? risk;
  String? buildNumber;
  String? timestamp;
  String? ndc;

  HyperpayStatus({
    this.id,
    this.paymentType,
    this.paymentBrand,
    this.amount,
    this.currency,
    this.descriptor,
    this.result,
    this.resultDetails,
    this.card,
    this.customer,
    this.customParameters,
    this.risk,
    this.buildNumber,
    this.timestamp,
    this.ndc,
  });

  HyperpayStatus copyWith({
    String? id,
    String? paymentType,
    String? paymentBrand,
    String? amount,
    String? currency,
    String? descriptor,
    Result? result,
    ResultDetails? resultDetails,
    VDCCard? card,
    Customer? customer,
    CustomParameters? customParameters,
    Risk? risk,
    String? buildNumber,
    String? timestamp,
    String? ndc,
  }) =>
      HyperpayStatus(
        id: id ?? this.id,
        paymentType: paymentType ?? this.paymentType,
        paymentBrand: paymentBrand ?? this.paymentBrand,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        descriptor: descriptor ?? this.descriptor,
        result: result ?? this.result,
        resultDetails: resultDetails ?? this.resultDetails,
        card: card ?? this.card,
        customer: customer ?? this.customer,
        customParameters: customParameters ?? this.customParameters,
        risk: risk ?? this.risk,
        buildNumber: buildNumber ?? this.buildNumber,
        timestamp: timestamp ?? this.timestamp,
        ndc: ndc ?? this.ndc,
      );

  factory HyperpayStatus.fromJson(Map<String, dynamic> json) => HyperpayStatus(
        id: json["id"],
        paymentType: json["paymentType"],
        paymentBrand: json["paymentBrand"],
        amount: json["amount"],
        currency: json["currency"],
        descriptor: json["descriptor"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        resultDetails: json["resultDetails"] == null
            ? null
            : ResultDetails.fromJson(json["resultDetails"]),
        card: json["card"] == null ? null : VDCCard.fromJson(json["card"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        customParameters: json["customParameters"] == null
            ? null
            : CustomParameters.fromJson(json["customParameters"]),
        risk: json["risk"] == null ? null : Risk.fromJson(json["risk"]),
        buildNumber: json["buildNumber"],
        timestamp: json["timestamp"],
        ndc: json["ndc"],
      );

  // from raw json
  factory HyperpayStatus.fromRawJson(String str) =>
      HyperpayStatus.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentType": paymentType,
        "paymentBrand": paymentBrand,
        "amount": amount,
        "currency": currency,
        "descriptor": descriptor,
        "result": result?.toJson(),
        "resultDetails": resultDetails?.toJson(),
        "card": card?.toJson(),
        "customer": customer?.toJson(),
        "customParameters": customParameters?.toJson(),
        "risk": risk?.toJson(),
        "buildNumber": buildNumber,
        "timestamp": timestamp,
        "ndc": ndc,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() =>
      'HyperpayStatus(id: $id, paymentType: $paymentType, paymentBrand: $paymentBrand, amount: $amount, currency: $currency, descriptor: $descriptor, result: $result, resultDetails: $resultDetails, card: $card, customer: $customer, customParameters: $customParameters, risk: $risk, buildNumber: $buildNumber, timestamp: $timestamp, ndc: $ndc)';
}

class VDCCard {
  String? bin;
  String? binCountry;
  String? last4Digits;
  String? holder;
  String? expiryMonth;
  String? expiryYear;
  Issuer? issuer;
  String? type;
  String? country;
  String? maxPanLength;
  String? regulatedFlag;

  VDCCard({
    this.bin,
    this.binCountry,
    this.last4Digits,
    this.holder,
    this.expiryMonth,
    this.expiryYear,
    this.issuer,
    this.type,
    this.country,
    this.maxPanLength,
    this.regulatedFlag,
  });

  VDCCard copyWith({
    String? bin,
    String? binCountry,
    String? last4Digits,
    String? holder,
    String? expiryMonth,
    String? expiryYear,
    Issuer? issuer,
    String? type,
    String? country,
    String? maxPanLength,
    String? regulatedFlag,
  }) =>
      VDCCard(
        bin: bin ?? this.bin,
        binCountry: binCountry ?? this.binCountry,
        last4Digits: last4Digits ?? this.last4Digits,
        holder: holder ?? this.holder,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        issuer: issuer ?? this.issuer,
        type: type ?? this.type,
        country: country ?? this.country,
        maxPanLength: maxPanLength ?? this.maxPanLength,
        regulatedFlag: regulatedFlag ?? this.regulatedFlag,
      );

  factory VDCCard.fromJson(Map<String, dynamic> json) => VDCCard(
        bin: json["bin"],
        binCountry: json["binCountry"],
        last4Digits: json["last4Digits"],
        holder: json["holder"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
        issuer: Issuer.fromJson(json["issuer"]),
        type: json["type"],
        country: json["country"],
        maxPanLength: json["maxPanLength"],
        regulatedFlag: json["regulatedFlag"],
      );

  factory VDCCard.fromRawJson(String str) => VDCCard.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "bin": bin,
        "binCountry": binCountry,
        "last4Digits": last4Digits,
        "holder": holder,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
        "issuer": issuer?.toJson(),
        "type": type,
        "country": country,
        "maxPanLength": maxPanLength,
        "regulatedFlag": regulatedFlag,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() =>
      'Card(bin: $bin, binCountry: $binCountry, last4Digits: $last4Digits, holder: $holder, expiryMonth: $expiryMonth, expiryYear: $expiryYear, issuer: $issuer, type: $type, country: $country, maxPanLength: $maxPanLength, regulatedFlag: $regulatedFlag)';
}

class Issuer {
  String? bank;
  String? website;
  String? phone;

  Issuer({
    this.bank,
    this.website,
    this.phone,
  });

  Issuer copyWith({
    String? bank,
    String? website,
    String? phone,
  }) =>
      Issuer(
        bank: bank ?? this.bank,
        website: website ?? this.website,
        phone: phone ?? this.phone,
      );

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        bank: json["bank"],
        website: json["website"],
        phone: json["phone"],
      );

  factory Issuer.fromRawJson(String str) => Issuer.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "website": website,
        "phone": phone,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => 'Issuer{bank: $bank, website: $website, phone: $phone}';
}

class CustomParameters {
  String? shopperMsdkIntegrationType;
  String? shopperDevice;
  String? ctpeDescriptorTemplate;
  String? shopperOs;
  String? shopperMsdkVersion;

  CustomParameters({
    this.shopperMsdkIntegrationType,
    this.shopperDevice,
    this.ctpeDescriptorTemplate,
    this.shopperOs,
    this.shopperMsdkVersion,
  });

  CustomParameters copyWith({
    String? shopperMsdkIntegrationType,
    String? shopperDevice,
    String? ctpeDescriptorTemplate,
    String? shopperOs,
    String? shopperMsdkVersion,
  }) =>
      CustomParameters(
        shopperMsdkIntegrationType:
            shopperMsdkIntegrationType ?? this.shopperMsdkIntegrationType,
        shopperDevice: shopperDevice ?? this.shopperDevice,
        ctpeDescriptorTemplate:
            ctpeDescriptorTemplate ?? this.ctpeDescriptorTemplate,
        shopperOs: shopperOs ?? this.shopperOs,
        shopperMsdkVersion: shopperMsdkVersion ?? this.shopperMsdkVersion,
      );

  factory CustomParameters.fromJson(Map<String, dynamic> json) =>
      CustomParameters(
        shopperMsdkIntegrationType: json["SHOPPER_MSDKIntegrationType"],
        shopperDevice: json["SHOPPER_device"],
        ctpeDescriptorTemplate: json["CTPE_DESCRIPTOR_TEMPLATE"],
        shopperOs: json["SHOPPER_OS"],
        shopperMsdkVersion: json["SHOPPER_MSDKVersion"],
      );

  factory CustomParameters.fromRawJson(String str) =>
      CustomParameters.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "SHOPPER_MSDKIntegrationType": shopperMsdkIntegrationType,
        "SHOPPER_device": shopperDevice,
        "CTPE_DESCRIPTOR_TEMPLATE": ctpeDescriptorTemplate,
        "SHOPPER_OS": shopperOs,
        "SHOPPER_MSDKVersion": shopperMsdkVersion,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() =>
      'CustomParameters{shopperMsdkIntegrationType: $shopperMsdkIntegrationType, shopperDevice: $shopperDevice, ctpeDescriptorTemplate: $ctpeDescriptorTemplate, shopperOs: $shopperOs, shopperMsdkVersion: $shopperMsdkVersion}';
}

class Customer {
  String? ip;
  String? ipCountry;

  Customer({this.ip, this.ipCountry});

  Customer copyWith({String? ip, String? ipCountry}) =>
      Customer(ip: ip ?? this.ip, ipCountry: ipCountry ?? this.ipCountry);

  factory Customer.fromJson(Map<String, dynamic> json) =>
      Customer(ip: json["ip"], ipCountry: json["ipCountry"]);

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {"ip": ip, "ipCountry": ipCountry};

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => 'Customer{ip: $ip, ipCountry: $ipCountry}';
}

class Result {
  String? code;
  String? description;

  Result({
    this.code,
    this.description,
  });

  Result copyWith({
    String? code,
    String? description,
  }) =>
      Result(
        code: code ?? this.code,
        description: description ?? this.description,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        description: json["description"],
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => 'Result{code: $code, description: $description}';
}

class ResultDetails {
  String? connectorTxId1;
  String? clearingInstituteName;

  ResultDetails({
    this.connectorTxId1,
    this.clearingInstituteName,
  });

  ResultDetails copyWith({
    String? connectorTxId1,
    String? clearingInstituteName,
  }) =>
      ResultDetails(
        connectorTxId1: connectorTxId1 ?? this.connectorTxId1,
        clearingInstituteName:
            clearingInstituteName ?? this.clearingInstituteName,
      );

  factory ResultDetails.fromJson(Map<String, dynamic> json) => ResultDetails(
        connectorTxId1: json["ConnectorTxID1"],
        clearingInstituteName: json["clearingInstituteName"],
      );

  factory ResultDetails.fromRawJson(String str) =>
      ResultDetails.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "ConnectorTxID1": connectorTxId1,
        "clearingInstituteName": clearingInstituteName,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() =>
      'ResultDetails{connectorTxId1: $connectorTxId1, clearingInstituteName: $clearingInstituteName}';
}

class Risk {
  String? score;

  Risk({this.score});

  Risk copyWith({String? score}) => Risk(score: score ?? this.score);

  factory Risk.fromJson(Map<String, dynamic> json) =>
      Risk(score: json["score"]);

  factory Risk.fromRawJson(String str) => Risk.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {"score": score};

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => 'Risk{score: $score}';
}
