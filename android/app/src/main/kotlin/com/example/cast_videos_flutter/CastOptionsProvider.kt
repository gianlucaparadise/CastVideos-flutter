package com.example.cast_videos_flutter

import android.content.Context
import com.google.android.gms.cast.framework.CastOptions
import com.google.android.gms.cast.framework.OptionsProvider
import com.google.android.gms.cast.framework.SessionProvider

class CastOptionsProvider : OptionsProvider {
    override fun getCastOptions(context: Context?): CastOptions {
        return CastOptions.Builder()
                .setReceiverApplicationId("C0868879")
                .build()
    }

    override fun getAdditionalSessionProviders(context: Context?): List<SessionProvider>? {
        return null
    }

}