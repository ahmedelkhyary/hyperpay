package com.excprotection.payment;

// Create your listener to override holder validation
public class CustomFormListener implements IPaymentFormListener {
    public CustomFormListener() {}
    
    @Override
    public CheckoutValidationResult onCardHolderValidate(String holder) {
        if(holder.length == 0) {
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
    public void writeToParcel(Parcel parcel, int i) {}
    
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