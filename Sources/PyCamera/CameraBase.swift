
import Foundation
import CoreImage
import PyCoreVideo
import PythonSwiftCore

public class CameraBase {
    
    let camera = CameraBackend()

    var py_callback: CameraBasePyCallback?

    private var previewBufferSize: Int = 0
    
    init() {
        Task {
            await handleCameraPreviews()
        }
    }
    
    func handleCameraPreviews() async {
        let pixelStream = camera.previewStream
        for await pixels in pixelStream {
            await handleBufferSize(pixels: pixels)
            await sendPreviewToPython(pixels: pixels)

        }
    }
    
    func handleBufferSize(pixels: CVPixelBuffer) async {
        let newSize = CVPixelBufferGetDataSize(pixels)
        if newSize != previewBufferSize {
            let w = CVPixelBufferGetBytesPerRow(pixels) / 4
            let h = CVPixelBufferGetHeight(pixels)
            
            await newPreviewTexture(h: h, w: w, buf_size: newSize)
        }
    }
    
    @MainActor
    func newPreviewTexture(h: Int, w: Int, buf_size: Int) async {
        previewBufferSize = buf_size
        guard let cb = py_callback else { return }
        cb.new_texture(w: w, h: h)
    }
    
    
    @MainActor
    func sendPreviewToPython(pixels: CVPixelBuffer) async {
        guard let cb = py_callback else { return }
        cb.on_frame(buffer: pixels.pyPointer)
    }
    
    
}

extension CameraBase: CameraBase_PyProtocol {
    
	public func start() {
        Task {
            await camera.start()
            //camera.switchCaptureDevice()
        }
    }
    
	public func stop() {
        camera.stop()
    }
    
    
}

