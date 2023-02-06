
import SnapKit

extension Array where Element: ConstraintView {
    
    public var snp: ConstraintArrayDSL {
        return ConstraintArrayDSL(array: self)
    }
}

