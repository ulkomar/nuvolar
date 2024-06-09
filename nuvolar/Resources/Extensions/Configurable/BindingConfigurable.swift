//
//  BindingConfigurable.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

protocol BindingConfigurableView {
   func configureBinding()
   func bindInput()
   func bindOutput()
   func bindInner()
}

extension BindingConfigurableView {
   func configureBinding() {
       bindInput()
       bindOutput()
       bindInner()
   }

   func bindInput() { }
   func bindOutput() { }
   func bindInner() { }
}

