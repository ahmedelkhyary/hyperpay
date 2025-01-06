package com.excprotection.payment;

import static com.oppwa.mobile.connect.payment.card.CardPaymentParams.isHolderValid;

import android.os.Parcel;

import androidx.annotation.NonNull;

import com.oppwa.mobile.connect.checkout.dialog.IPaymentFormListener;
import com.oppwa.mobile.connect.checkout.meta.CheckoutValidationResult;

// Create your listener to override holder validation
public class CustomFormListener implements IPaymentFormListener {
    public CustomFormListener() {}

    @NonNull
    @Override
    public CheckoutValidationResult onCardHolderValidate(String holder) {
        if(holder != null && holder.isEmpty()) {
            return CheckoutValidationResult.NOT_VALID;
        }
        if (isHolderValid(holder)) {
            return CheckoutValidationResult.VALID;
        } else {
            return CheckoutValidationResult.NOT_VALID;
        }
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(@NonNull Parcel dest, int flags) {

    }

    
    private CustomFormListener(Parcel in) {}

    public static final Creator<CustomFormListener> CREATOR = new Creator<CustomFormListener>() {
        @Override
        public CustomFormListener createFromParcel(Parcel in) {
            return new CustomFormListener(in);
        }

        @Override
        public CustomFormListener[] newArray(int size) {
            return new CustomFormListener[size];
        }
    };
}