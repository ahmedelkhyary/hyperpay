package com.excprotection.payment;

import com.oppwa.mobile.connect.payment.PaymentParams;
import com.oppwa.mobile.connect.payment.card.CardPaymentParams;
import com.oppwa.mobile.connect.payment.stcpay.STCPayPaymentParams;
import com.oppwa.mobile.connect.payment.stcpay.STCPayVerificationOption;
import com.oppwa.mobile.connect.provider.ITransactionListener;
import com.oppwa.mobile.connect.provider.OppPaymentProvider;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity;
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings;
import com.oppwa.mobile.connect.checkout.meta.CheckoutStorePaymentDetailsMode;
import com.oppwa.mobile.connect.exception.PaymentError;
import com.oppwa.mobile.connect.exception.PaymentException;
import com.oppwa.mobile.connect.payment.BrandsValidation;
import com.oppwa.mobile.connect.payment.CheckoutInfo;
import com.oppwa.mobile.connect.payment.ImagesRequest;
import com.oppwa.mobile.connect.payment.token.TokenPaymentParams;
import com.oppwa.mobile.connect.provider.Connect;
import com.oppwa.mobile.connect.provider.ThreeDSWorkflowListener;
//import com.oppwa.mobile.connect.provider.ITransactionListener;
import com.oppwa.mobile.connect.provider.Transaction;
import com.oppwa.mobile.connect.provider.TransactionType;
import com.oppwa.mobile.connect.checkout.dialog.GooglePayHelper;
import com.oppwa.mobile.connect.payment.googlepay.GooglePayPaymentParams;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.wallet.AutoResolveHelper;
import com.google.android.gms.wallet.PaymentData;
import com.google.android.gms.wallet.PaymentDataRequest;
import com.google.android.gms.wallet.PaymentsClient;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import android.widget.Toast;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class PaymentPlugin  implements
        PluginRegistry.ActivityResultListener ,ActivityAware
        , FlutterPlugin, MethodCallHandler , PluginRegistry.NewIntentListener, ITransactionListener {

  private  MethodChannel.Result Result;
  private  String mode = "";
  private List<String> brandsReadyUi ;
  private String brands = "" ;
  private String Lang = "";
  private String EnabledTokenization = "";
  private String ShopperResultUrl = "";
  private String setStorePaymentDetailsMode = "";
  private String number, holder, cvv, year, month;
  private String TokenID = "";
  private OppPaymentProvider paymentProvider  = null ;
  private Activity activity;
  private Context context;

  // Google Pay fields
  private static final int LOAD_PAYMENT_DATA_REQUEST_CODE = 991;
  private String googlePayMerchantId = "";
  private String gatewayMerchantId = "";
  private String googlePayCountryCode = "";
  private String googlePayCurrencyCode = "";
  private String googlePayAmount = "";
  private List<String> allowedCardNetworks;
  private List<String> allowedCardAuthMethods;
  private String googlePayCheckoutId = "";
  private PaymentsClient paymentsClient;


  private final Handler handler = new Handler(Looper.getMainLooper());

  /// The MethodChannel that will the communication between Flutter and native Android
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity

  private MethodChannel channel;
  String CHANNEL = "Hyperpay.demo.fultter/channel";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL);
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    Result = result;
    if (call.method.equals("gethyperpayresponse")) {

      String checkoutId = call.argument("checkoutid");
      String type = call.argument("type");
      mode = call.argument("mode");
      Lang = call.argument("lang");
      ShopperResultUrl = call.argument("ShopperResultUrl");

      switch (type != null ? type : "NullType") {
        case "ReadyUI" :
          brandsReadyUi = call.argument("brand");
          setStorePaymentDetailsMode = call.argument("setStorePaymentDetailsMode");
          openCheckoutUI(checkoutId) ;
        break;
        case "StoredCards" :
          cvv = call.argument("cvv");
          TokenID = call.argument("TokenID");
          brands = call.argument("brand");
          storedCardPayment(checkoutId);
          break;

        case "CustomUI" :
          brands = call.argument("brand");
          number = call.argument("card_number");
          holder = call.argument("holder_name");
          year = call.argument("year");
          month = call.argument("month");
          cvv = call.argument("cvv");
          EnabledTokenization = call.argument("EnabledTokenization");
          openCustomUI(checkoutId);
          break;

        case "CustomUISTC":
          number = call.argument("phone_number");
          openCustomUISTC(checkoutId);
          break;

        case "GooglePayUI":
          googlePayCheckoutId = checkoutId;
          googlePayMerchantId = call.argument("googlePayMerchantId");
          gatewayMerchantId = call.argument("gatewayMerchantId");
          googlePayCountryCode = call.argument("countryCode");
          googlePayCurrencyCode = call.argument("currencyCode");
          googlePayAmount = call.argument("amount");
          allowedCardNetworks = call.argument("allowedCardNetworks");
          allowedCardAuthMethods = call.argument("allowedCardAuthMethods");
          openGooglePayUI();
          break;

        default : error("1", "THIS TYPE NO IMPLEMENT" + type, "");
      }

    } else {
      notImplemented();
    }

  }

  private void openCheckoutUI(String checkoutId) {

    Set<String> paymentBrands = new LinkedHashSet<>(brandsReadyUi);
    // CHECK PAYMENT MODE
    CheckoutSettings checkoutSettings;
    if (mode.equals("live")) {
      //LIVE MODE
      checkoutSettings = new CheckoutSettings(checkoutId, paymentBrands,
              Connect.ProviderMode.LIVE);
    } else {
      // TEST MODE
      checkoutSettings = new CheckoutSettings(checkoutId, paymentBrands,
              Connect.ProviderMode.TEST);
    }

    // SET LANG
    checkoutSettings.setLocale(Lang);

    checkoutSettings.setPaymentFormListener(new CustomFormListener());

    // SHOW TOTAL PAYMENT AMOUNT IN BUTTON
    // checkoutSettings.setTotalAmountRequired(true);

    //SET SHOPPER
    //checkoutSettings.setShopperResultUrl(ShopperResultUrl + "://result");

    //SAVE PAYMENT CARDS FOR NEXT
    if (setStorePaymentDetailsMode.equals("true")) {
      checkoutSettings.setStorePaymentDetailsMode(CheckoutStorePaymentDetailsMode.PROMPT);
    }
    //CHANGE THEME
    checkoutSettings.setThemeResId(R.style.NewCheckoutTheme);

    // CHECKOUT BROADCAST RECEIVER
    ComponentName componentName = new ComponentName(
            context.getPackageName(), CheckoutBroadcastReceiver.class.getName());

    // SET UP THE INTENT AND START THE CHECKOUT ACTIVITY

    Intent intent = new Intent(context.getApplicationContext(), CheckoutActivity.class);
    intent.putExtra(CheckoutActivity.CHECKOUT_SETTINGS, checkoutSettings);
    intent.putExtra(CheckoutActivity.CHECKOUT_RECEIVER, componentName);

    // START ACTIVITY
    activity.startActivityForResult(intent, 242);

  }

  private void storedCardPayment(String checkoutId) {
    try {
        TokenPaymentParams paymentParams;
        if (cvv != null && !cvv.isEmpty()) {
            paymentParams = new TokenPaymentParams(checkoutId, TokenID, brands, cvv);
        } else {
            paymentParams = new TokenPaymentParams(checkoutId, TokenID, brands);
        }

        paymentParams.setShopperResultUrl(ShopperResultUrl + "://result");

        Transaction transaction = new Transaction(paymentParams);

      //Set Mode;
        boolean resultMode = mode.equals("test");
        Connect.ProviderMode providerMode;

        if (resultMode) {
            providerMode = Connect.ProviderMode.TEST;
        } else {
            providerMode = Connect.ProviderMode.LIVE;
        }

        paymentProvider = new OppPaymentProvider(activity.getBaseContext(), providerMode);

        // Ensure ThreeDS workflow listener is provided (SDK requires non-null listener)
        paymentProvider.setThreeDSWorkflowListener(new ThreeDSWorkflowListener() {
            @Override
            public Activity onThreeDSChallengeRequired() {
                return activity;
            }
        });

        //Submit Transaction
        //Listen for transaction Completed - transaction Failed
        paymentProvider.submitTransaction(transaction, this);

    } catch (PaymentException e) {
        e.printStackTrace();
    }
}

  private void openCustomUI(String checkoutId) {

    Toast.makeText(activity.getApplicationContext(), Lang.equals("en_US")
            ? "Please Waiting.."
            : "برجاء الانتظار..", Toast.LENGTH_SHORT).show();

        if (!CardPaymentParams.isNumberValid(number , true)) {
          Toast.makeText(activity.getApplicationContext(), Lang.equals("en_US")
                  ? "Card number is not valid for brand"
                  : "رقم البطاقة غير صالح",
                  Toast.LENGTH_SHORT).show();
        } else if (!CardPaymentParams.isHolderValid(holder)) {
          Toast.makeText(activity.getApplicationContext(),  Lang.equals("en_US")
                  ? "Holder name is not valid"
                  : "اسم المالك غير صالح"
                  , Toast.LENGTH_SHORT).show();
        } else if (!CardPaymentParams.isExpiryYearValid(year)) {
          Toast.makeText(activity.getApplicationContext(),  Lang.equals("en_US")
                  ? "Expiry year is not valid"
                  : "سنة انتهاء الصلاحية غير صالحة" ,
                  Toast.LENGTH_SHORT).show();
        } else if (!CardPaymentParams.isExpiryMonthValid(month)) {
          Toast.makeText(activity.getApplicationContext(),  Lang.equals("en_US")
                  ? "Expiry month is not valid"
                  : "شهر انتهاء الصلاحية غير صالح"
                  , Toast.LENGTH_SHORT).show();
        } else if (!CardPaymentParams.isCvvValid(cvv)) {
          Toast.makeText(activity.getApplicationContext(),  Lang.equals("en_US")
                  ? "CVV is not valid"
                  : "CVV غير صالح"
                  , Toast.LENGTH_SHORT).show();
        } else {

          boolean EnabledTokenizationTemp = EnabledTokenization.equals("true");
          try {
            PaymentParams paymentParams = new CardPaymentParams(
                    checkoutId, brands, number, holder, month, year, cvv
            ).setTokenizationEnabled(EnabledTokenizationTemp);//Set Enabled TokenizationTemp

            paymentParams.setShopperResultUrl(ShopperResultUrl + "://result");

            Transaction transaction = new Transaction(paymentParams);

            //Set Mode;
            boolean resultMode = mode.equals("test");
            Connect.ProviderMode providerMode ;

            if (resultMode) {
              providerMode =  Connect.ProviderMode.TEST ;
            } else {
              providerMode =  Connect.ProviderMode.LIVE ;
            }

            paymentProvider = new OppPaymentProvider(activity.getBaseContext(), providerMode);

            // Ensure ThreeDS workflow listener is provided (SDK requires non-null listener)
            paymentProvider.setThreeDSWorkflowListener(new ThreeDSWorkflowListener() {
              @Override
              public Activity onThreeDSChallengeRequired() {
                return activity;
              }
            });

            //Submit Transaction
            //Listen for transaction Completed - transaction Failed
            paymentProvider.submitTransaction(transaction, this);

          } catch (PaymentException e) {
            error("0.1", e.getLocalizedMessage(), "");
          }
        }
  }

  private void openCustomUISTC(String checkoutId) {

    Toast.makeText(activity.getApplicationContext(), Lang.equals("en_US")
            ? "Please Waiting.."
            : "برجاء الانتظار..", Toast.LENGTH_SHORT).show();
    try {
        //Set Mode
        boolean resultMode = mode.equals("test");
        Connect.ProviderMode providerMode ;

        if (resultMode) {
          providerMode =  Connect.ProviderMode.TEST ;
        } else {
          providerMode =  Connect.ProviderMode.LIVE ;
        }

        STCPayPaymentParams stcPayPaymentParams = new STCPayPaymentParams(checkoutId, STCPayVerificationOption.MOBILE_PHONE);

        stcPayPaymentParams.setMobilePhoneNumber(number);

        stcPayPaymentParams.setShopperResultUrl(ShopperResultUrl + "://result");

        Transaction transaction = new Transaction(stcPayPaymentParams);

        paymentProvider = new OppPaymentProvider(activity.getBaseContext(), providerMode);

        //Submit Transaction
        //Listen for transaction Completed - transaction Failed
        // Ensure ThreeDS workflow listener is provided (SDK requires non-null listener)
        paymentProvider.setThreeDSWorkflowListener(new ThreeDSWorkflowListener() {
          @Override
          public Activity onThreeDSChallengeRequired() {
            return activity;
          }
        });

        paymentProvider.submitTransaction(transaction, this);

      } catch (PaymentException e) {
        e.printStackTrace();
      }

  }

  private void openGooglePayUI() {
    // Match UI with other payment methods - show loading toast
    Toast.makeText(activity.getApplicationContext(), Lang.equals("en_US")
            ? "Please Wait.."
            : "برجاء الانتظار..", Toast.LENGTH_SHORT).show();

    // Get provider mode
    Connect.ProviderMode providerMode = mode.equals("test")
            ? Connect.ProviderMode.TEST
            : Connect.ProviderMode.LIVE;

    // Build the payment data request JSON
    String paymentDataRequestJson = buildGooglePayRequest();

    // Check if Google Pay is available
    try {
      GooglePayHelper.isReadyToPayWithGoogle(
              context,
              providerMode,
              paymentDataRequestJson,
              new OnCompleteListener<Boolean>() {
                @Override
                public void onComplete(@NonNull Task<Boolean> task) {
                  if (task.isSuccessful() && task.getResult() != null && task.getResult()) {
                    requestGooglePayPayment(providerMode, paymentDataRequestJson);
                  } else {
                    error("GOOGLE_PAY_NOT_AVAILABLE", "Google Pay is not available on this device", "");
                  }
                }
              }
      );
    } catch (PaymentException e) {
      error("GOOGLE_PAY_ERROR", e.getMessage(), "");
    }
  }

  private void requestGooglePayPayment(Connect.ProviderMode providerMode, String paymentDataRequestJson) {
    paymentsClient = GooglePayHelper.getPaymentsClient(context, providerMode);

    try {
      PaymentDataRequest request = PaymentDataRequest.fromJson(paymentDataRequestJson);
      if (request != null) {
        AutoResolveHelper.resolveTask(
                paymentsClient.loadPaymentData(request),
                activity,
                LOAD_PAYMENT_DATA_REQUEST_CODE
        );
      } else {
        error("GOOGLE_PAY_ERROR", "Failed to create payment data request", "");
      }
    } catch (Exception e) {
      error("GOOGLE_PAY_ERROR", e.getMessage(), "");
    }
  }

  private String buildGooglePayRequest() {
    try {
      // Build allowed card networks array
      JSONArray cardNetworks = new JSONArray();
      if (allowedCardNetworks != null) {
        for (String network : allowedCardNetworks) {
          cardNetworks.put(network);
        }
      }

      // Build allowed auth methods array
      JSONArray authMethods = new JSONArray();
      if (allowedCardAuthMethods != null) {
        for (String method : allowedCardAuthMethods) {
          authMethods.put(method);
        }
      }

      // Card payment method parameters
      JSONObject cardParameters = new JSONObject();
      cardParameters.put("allowedAuthMethods", authMethods);
      cardParameters.put("allowedCardNetworks", cardNetworks);
      cardParameters.put("billingAddressRequired", false);

      // Tokenization specification - HyperPay uses ACI Worldwide's OPPWA platform
      JSONObject tokenizationParameters = new JSONObject();
      tokenizationParameters.put("gateway", "aciworldwide");
      tokenizationParameters.put("gatewayMerchantId", gatewayMerchantId);

      JSONObject tokenizationSpecification = new JSONObject();
      tokenizationSpecification.put("type", "PAYMENT_GATEWAY");
      tokenizationSpecification.put("parameters", tokenizationParameters);

      // Card payment method
      JSONObject cardPaymentMethod = new JSONObject();
      cardPaymentMethod.put("type", "CARD");
      cardPaymentMethod.put("parameters", cardParameters);
      cardPaymentMethod.put("tokenizationSpecification", tokenizationSpecification);

      JSONArray allowedPaymentMethods = new JSONArray();
      allowedPaymentMethods.put(cardPaymentMethod);

      // Transaction info
      JSONObject transactionInfo = new JSONObject();
      transactionInfo.put("totalPrice", googlePayAmount);
      transactionInfo.put("totalPriceStatus", "FINAL");
      transactionInfo.put("currencyCode", googlePayCurrencyCode);
      transactionInfo.put("countryCode", googlePayCountryCode);

      // Merchant info
      JSONObject merchantInfo = new JSONObject();
      merchantInfo.put("merchantId", googlePayMerchantId);
      merchantInfo.put("merchantName", "");

      // Build the full request
      JSONObject paymentDataRequest = new JSONObject();
      paymentDataRequest.put("apiVersion", 2);
      paymentDataRequest.put("apiVersionMinor", 0);
      paymentDataRequest.put("allowedPaymentMethods", allowedPaymentMethods);
      paymentDataRequest.put("transactionInfo", transactionInfo);
      paymentDataRequest.put("merchantInfo", merchantInfo);

      return paymentDataRequest.toString();
    } catch (JSONException e) {
      return "{}";
    }
  }

  private void handleGooglePayResult(int resultCode, Intent data) {
    switch (resultCode) {
      case Activity.RESULT_OK:
        PaymentData paymentData = PaymentData.getFromIntent(data);
        if (paymentData != null) {
          try {
            String paymentInfo = paymentData.toJson();
            JSONObject paymentDataJson = new JSONObject(paymentInfo);

            // Extract payment method data
            JSONObject paymentMethodData = paymentDataJson.getJSONObject("paymentMethodData");
            JSONObject tokenizationData = paymentMethodData.getJSONObject("tokenizationData");
            String token = tokenizationData.getString("token");

            // Extract card info
            JSONObject cardInfo = paymentMethodData.getJSONObject("info");
            String cardNetwork = cardInfo.getString("cardNetwork");

            // Submit to HyperPay
            submitGooglePayTransaction(token, cardNetwork);

          } catch (JSONException e) {
            error("GOOGLE_PAY_ERROR", "Failed to parse payment data: " + e.getMessage(), "");
          }
        } else {
          error("GOOGLE_PAY_ERROR", "Payment data is null", "");
        }
        break;

      case Activity.RESULT_CANCELED:
        error("GOOGLE_PAY_CANCELED", "Google Pay was canceled", "");
        break;

      default:
        error("GOOGLE_PAY_ERROR", "Google Pay failed with result code: " + resultCode, "");
        break;
    }
  }

  private void submitGooglePayTransaction(String paymentToken, String cardBrand) {
    try {
      // Get provider mode
      Connect.ProviderMode providerMode = mode.equals("test")
              ? Connect.ProviderMode.TEST
              : Connect.ProviderMode.LIVE;

      // Create Google Pay payment params
      GooglePayPaymentParams googlePayParams = new GooglePayPaymentParams(
              googlePayCheckoutId,
              paymentToken,
              cardBrand
      );

      googlePayParams.setShopperResultUrl(ShopperResultUrl + "://result");

      // Create transaction
      Transaction transaction = new Transaction(googlePayParams);

      // Create payment provider
      paymentProvider = new OppPaymentProvider(activity.getBaseContext(), providerMode);

      // Set 3DS listener
      paymentProvider.setThreeDSWorkflowListener(new ThreeDSWorkflowListener() {
        @Override
        public Activity onThreeDSChallengeRequired() {
          return activity;
        }
      });

      // Submit transaction
      paymentProvider.submitTransaction(transaction, this);

    } catch (PaymentException e) {
      error("GOOGLE_PAY_ERROR", e.getMessage(), "");
    }
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    // Handle Google Pay result
    if (requestCode == LOAD_PAYMENT_DATA_REQUEST_CODE) {
      handleGooglePayResult(resultCode, data);
      return true;
    }

    switch (resultCode) {
      case CheckoutActivity.RESULT_OK :
        /* transaction completed */
        Transaction transaction = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_TRANSACTION);


        /* resource path if needed */
        // String resourcePath = data.getStringExtra(CheckoutActivity.CHECKOUT_RESULT_RESOURCE_PATH);
        if (transaction.getTransactionType() == TransactionType.SYNC) {
          /* check the result of synchronous transaction */
          success("SYNC");
        }

      break ;
      case CheckoutActivity.RESULT_CANCELED :
              /* shopper canceled the checkout process */
              error("2", "Canceled", "");
        break ;

      case CheckoutActivity.RESULT_ERROR :
              /* shopper error the checkout process */
              error("3", "Checkout Result Error", "");
        break ;

    }

    return  true ;
  }

  public void success(final Object result) {
    handler.post(
            () -> Result.success(result));
  }

  public void error(
          @NonNull final String errorCode, final String errorMessage, final Object errorDetails) {
    handler.post(
            () -> Result.error(errorCode, errorMessage, errorDetails));
  }

  public void notImplemented() {
    handler.post(
            () -> Result.notImplemented());
  }

  @Override
  public boolean onNewIntent(@NonNull Intent intent) {
    // TO BACK TO VIEW
    if (intent.getScheme() != null && intent.getScheme().equals(ShopperResultUrl)) {
      success("success");
    }
    return  true ;
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    binding.addActivityResultListener(this);
    binding.addOnNewIntentListener(this); // TO LISTEN ON NEW INTENT OPEN

  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }

  @Override
  public void transactionCompleted(@NonNull Transaction transaction) {
    if (transaction.getTransactionType() == TransactionType.SYNC) {
      success("SYNC");
    } else {
      /* wait for the callback in the s */
      Uri uri = Uri.parse(transaction.getRedirectUrl());
      Intent intent = new Intent(Intent.ACTION_VIEW, uri);
      activity.startActivity(intent);
    }
  }

  @Override
  public void transactionFailed(@NonNull Transaction transaction, @NonNull PaymentError paymentError) {
    error("transactionFailed", paymentError.getErrorMessage(), "transactionFailed"
    );
  }

  @Override
  public void brandsValidationRequestSucceeded(@NonNull BrandsValidation brandsValidation) {
    ITransactionListener.super.brandsValidationRequestSucceeded(brandsValidation);
  }

  @Override
  public void brandsValidationRequestFailed(@NonNull PaymentError error) {
    ITransactionListener.super.brandsValidationRequestFailed(error);
  }

  @Override
  public void paymentConfigRequestSucceeded(@NonNull CheckoutInfo checkoutInfo) {
    ITransactionListener.super.paymentConfigRequestSucceeded(checkoutInfo);
  }

  @Override
  public void paymentConfigRequestFailed(@NonNull PaymentError error) {
    ITransactionListener.super.paymentConfigRequestFailed(error);
  }

  @Override
  public void imagesRequestSucceeded(@NonNull ImagesRequest imagesRequest) {
    ITransactionListener.super.imagesRequestSucceeded(imagesRequest);
  }

  @Override
  public void imagesRequestFailed() {
    ITransactionListener.super.imagesRequestFailed();
  }

  @Override
  public void binRequestSucceeded(@NonNull String[] brands) {
    ITransactionListener.super.binRequestSucceeded(brands);
  }

  @Override
  public void binRequestFailed() {
    ITransactionListener.super.binRequestFailed();
  }
}
