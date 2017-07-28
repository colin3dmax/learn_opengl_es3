//
//  ViewController.swift
//  Game01
//
//  Created by colin3dmax on 2017/7/28.
//  Copyright © 2017年 colin3dmax. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    var context:EAGLContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.context = EAGLContext.init(api: .openGLES3)
        if self.context == nil {
            print("Failed to create ES context")
        }
        let view = self.view as! GLKView
        view.context = self.context!
        view.drawableDepthFormat = .format24
        
        self.setupGL()
    }
    
    deinit{
        self.tearDownGL()
        if( EAGLContext.current()==self.context){
            EAGLContext.setCurrent(nil)
        }
        
        print("ViewController deinit")
    }
    
    override var shouldAutorotate: Bool {
        
        get{
            EAGLContext.setCurrent(self.context)
            GraphicsResize(Int32(self.view.bounds.size.width), Int32(self.view.bounds.size.width))
            return true
        }
    }
    
    func setupGL(){
        EAGLContext.setCurrent(self.context!)
        var defaultFBO:GLint = 0
        var defaultRBO:GLint = 0
        
        glGetIntegerv(GLenum(GL_FRAMEBUFFER_BINDING), &defaultFBO)
        glGetIntegerv(GLenum(GL_RENDERBUFFER_BINDING), &defaultRBO)
        
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), GLuint(defaultFBO))
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), GLuint(defaultRBO))
        
        GraphicsInit();
    }
    
    func tearDownGL(){
        EAGLContext.setCurrent(self.context)
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        GraphicsRender()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

