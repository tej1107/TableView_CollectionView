
import UIKit

class MainCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img.layer.cornerRadius = self.img.frame.height / 2
        self.img.layer.borderWidth = 1.0
        self.img.layer.borderColor = UIColor.lightGray.cgColor
        self.img.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
