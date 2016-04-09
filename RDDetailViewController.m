//
//  RDDetailViewController.m
//  Homeowner
//
//  Created by Ridhdhi Desai on 3/26/16.
//  Copyright © 2016 Ridhdhi Desai. All rights reserved.
//

#import "RDDetailViewController.h"
#import "Items.h"
#import "RDImageStore.h"

@interface RDDetailViewController ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;


@end

@implementation RDDetailViewController

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //if the device has a camera take a picture otherwise just pick it from the photo library
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

-(void) viewWillAppear:(BOOL)animated {
    
    Items *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    //You need NSDateFormatter that will turn a date into a simple data string
    static NSDateFormatter *dateFormatter;
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    //Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    NSString *itemKey = self.item.itemKey;
   
    //Get the image for its key from the image store
    UIImage *imageToDisplay = [[RDImageStore sharedStore] imageForKey:itemKey];
    
    //Use that image to put on the screen in the image view
    self.imageView.image = imageToDisplay;
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //Clear first responder
    [self.view endEditing:YES];
    
    //"Save" changes to item
    Items *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
}

-(void) setItem:(Items *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //put that image onto the screen in our image view
    self.imageView.image = image;
    
    //Store the image in the RDImageStore for this key
    [[RDImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    //Take the image picker off the screen
    //You must call this dismiss mentiod
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
