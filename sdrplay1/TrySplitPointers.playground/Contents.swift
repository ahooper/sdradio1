import Accelerate.vecLib

var ra1 = Array<Float>(), ia1 = Array<Float>()
let sa1 = DSPSplitComplex(realp: &ra1, imagp: &ia1)

var rca = ContiguousArray<Float>(), ica = ContiguousArray<Float>()
//let sca = DSPSplitComplex(realp: &rca, imagp: &ica)
rca.withUnsafeMutableBufferPointer { (rcb: inout UnsafeMutableBufferPointer<Float> ) in
    ica.withUnsafeMutableBufferPointer { (icb: inout UnsafeMutableBufferPointer<Float>) in
        let sca = DSPSplitComplex(realp: rcb.baseAddress!,
                                  imagp: icb.baseAddress!)
    }
}
