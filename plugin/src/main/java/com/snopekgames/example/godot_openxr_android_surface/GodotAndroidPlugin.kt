package com.snopekgames.example.godot_openxr_android_surface

import android.media.MediaPlayer
import android.view.Surface
import org.godotengine.godot.Godot
import org.godotengine.godot.plugin.GodotPlugin
import org.godotengine.godot.plugin.UsedByGodot

class GodotAndroidPlugin(godot: Godot) : GodotPlugin(godot) {

    private var mediaPlayer: MediaPlayer? = null

    override fun getPluginName() = BuildConfig.GODOT_PLUGIN_NAME

    @UsedByGodot
    fun updateSurface(surface: Surface?) {
        if (surface == null) {
            mediaPlayer?.release()
            mediaPlayer = null
            return
        }

        if (mediaPlayer == null) {
            mediaPlayer = MediaPlayer()
        }

        val activity = godot.getActivity() ?: run {
            mediaPlayer?.release()
            mediaPlayer = null
            return
        }

        try {
            activity.resources.openRawResourceFd(R.raw.sample_video).use { afd ->
                mediaPlayer!!.apply {
                    setDataSource(afd.fileDescriptor, afd.startOffset, afd.length)
                    setSurface(surface)
                    isLooping = true
                    setOnPreparedListener { it.start() }
                    setOnCompletionListener { it.release() }
                    setOnErrorListener { mp, _, _ ->
                        mp.release()
                        true
                    }
                    prepareAsync()
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
            mediaPlayer?.release()
            mediaPlayer = null
        }
    }
}
