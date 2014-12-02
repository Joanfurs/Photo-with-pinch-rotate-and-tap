
import UIKit
import GLKit;	

class View: UIView {

	var previousScale: CGFloat = 0;
	var index: Int = 0;

	override init(frame: CGRect) {
		super.init(frame: frame);
		backgroundColor = UIColor.blackColor();
		
	/*	
		let names: [String] = [
		"1",
		"2",
		"3"  
	];

		let image: UIImage? = UIImage(named: "/(names[index])");
	*/
		
		// Image
		
		let image: UIImage? = UIImage(named: "1");

		if image == nil {
			println("could not create image");
			return;
		}
		var imageView: UIImageView = UIImageView(image: image);
		imageView.center = center;
		addSubview(imageView);
		
		// Pinch
		
		let recognizer: UIPinchGestureRecognizer =
			UIPinchGestureRecognizer(target: self, action: "pinch:");
		previousScale = recognizer.scale;
		addGestureRecognizer(recognizer);
		
		// Rotate
		
		let recognizer2: UIRotationGestureRecognizer =
			UIRotationGestureRecognizer(target: self, action: "rotate:");
		addGestureRecognizer(recognizer2);
		
		//Tap
		
		/*
		let recognizer3: UITapGestureRecognizer =
			UITapGestureRecognizer(target: self, action: "swichPhoto:");
		recognizer3.numberOfTapsRequired = 2;
		addGestureRecognizer(recognizer3);
		
	*/
	
	}


	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	

	func pinch(recognizer: UIPinchGestureRecognizer) -> Void {
	
		let currentScale: CGFloat = recognizer.scale;

		if abs(currentScale - previousScale) <= 0.1 {
		
			let imageView: UIImageView = subviews[subviews.count - 1] as UIImageView;

			let factor: CGFloat = currentScale / previousScale;

			let newSize: CGSize = CGSizeMake(
				factor * imageView.frame.size.width,
				factor * imageView.frame.size.height);

			imageView.frame = CGRectMake(
				(frame.size.width - newSize.width) / 2,
				(frame.size.height - newSize.height) / 2,
				newSize.width,
				newSize.height);

		}
		
			previousScale = currentScale;

	}


	func rotate(recognizer2: UIRotationGestureRecognizer) {
	
		let radians: Float = Float(recognizer2.rotation);
		let degrees: Float = GLKMathRadiansToDegrees(radians);
		println("recognizer.rotation = \(degrees)");
		let imageView: UIImageView = subviews[subviews.count - 1] as UIImageView;

		imageView.transform = CGAffineTransformMakeRotation(recognizer2.rotation);
		
	}
	
	/*
	func swichPhoto(recognizer3: UITapGestureRecognizer) -> Void {

		if index < 2  {
		index = index + 1;
		} else {
		index = 0;
		}
		
		let imageView: UIImageView = subviews[subviews.count - 1] as UIImageView;
		imageView.center = center;

	}
	*/

	override func layoutSubviews() {
	
		let imageView: UIImageView = subviews[subviews.count - 1] as UIImageView;
		imageView.center = center;
	}

}