extends Node3D

var _plugin_name = "GodotOpenXRAndroidSurfaceExample"
var _android_plugin


func _ready() -> void:
	if Engine.has_singleton(_plugin_name):
		_android_plugin = Engine.get_singleton(_plugin_name)
	else:
		printerr("Couldn't find plugin " + _plugin_name)

	var xr_interface: OpenXRInterface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		xr_interface.session_begun.connect(_on_openxr_session_begun)

		var system_info := xr_interface.get_system_info()
		var xr_runtime_name: String = system_info['XRRuntimeName']
		var renderer := RenderingServer.get_current_rendering_driver_name()

		# Work around inconsistent implementations of XR_KHR_android_surface_swapchain.
		var flip_composition_layer := false
		if xr_runtime_name.begins_with('Oculus'):
			flip_composition_layer = (renderer == "opengl3" or renderer == "opengl3_es")
		elif xr_runtime_name.begins_with('Pico'):
			flip_composition_layer = (renderer == "vulkan")

		%OpenXRCompositionLayerQuad.set('XR_FB_composition_layer_image_layout/vertical_flip', flip_composition_layer)


func _on_openxr_session_begun() -> void:
	if _android_plugin:
		var android_surface = %OpenXRCompositionLayerQuad.get_android_surface()
		if android_surface:
			print("We have the Android surface")
			_android_plugin.updateSurface(android_surface, "sample_video.mp4")
		else:
			print("We have no Android surface")
