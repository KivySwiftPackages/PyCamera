from swift_tools.swift_types import * # type: ignore

"import AVFoundation"

# with SwiftImports:
#     "AVFoundation"


@wrapper()
class CameraBase:

    def __init__(self): ...

    def set_callback(self, callback: object): ...
    class Callbacks:

        def new_texture(self, w: int, h: int): ...

        def on_frame(self, buffer: object): ...

    def start(self): ...

    def stop(self): ...
