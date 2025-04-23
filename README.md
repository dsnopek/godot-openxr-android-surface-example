# Godot OpenXR Android Surface Example (using a Godot Android plugin)

This repository contains a Godot example project showing OpenXR composition layers based on Android surfaces for Godot 4.4+.

It plays a short, looping video clip, using Android's `MediaPlayer` which should take advantage of hardware video decoding if it's available on the device.

[Watch a video of the project running.](https://drive.google.com/file/d/14gzOJAdkac-jeQDLyZXvWfq2LvutPz94/view?usp=sharing)

## This example uses a Godot Android plugin

In order to run custom Kotlin code, this example uses a [Godot Android plugin](https://docs.godotengine.org/en/latest/tutorials/platform/android/android_plugin.html).

So, before you can export it, you need to run:

```
./gradlew assemble
```

Using a Godot Android plugin allows you to do anything that's possible in an Android app, using Android's native tools.

However, if you'd like to only use GDScript, please take a look at this [alternative example](https://github.com/dsnopek/godot-openxr-android-surface-javaclasswrapper-example), which may be enough for simple video file playback.

## License

Unless otherwise specified (for example, in the "CREDITS" section below), this project is distributed under the terms of the [MIT License](LICENSE).

## Credits

The video clip used is from "Big Buck Bunny", (c) copyright 2008 [Blender Foundation](https://www.blender.org) / [www.bigbuckbunny.org](https://www.bigbuckbunny.org), and licensed under the [CC-BY 3.0 license](https://creativecommons.org/licenses/by/3.0/).
