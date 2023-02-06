
import SnapKit

extension Array where Element: ConstraintView {
    
    var snp: ConstraintArrayDSL {
        return ConstraintArrayDSL(array: self)
    }
}

