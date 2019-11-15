fn(a: i32, b: i32) ->i32{
    

fn main() {
    let mut count = 0u32;
    loop {
        count += 1;

        if count == 3 {
            continue;
        }

        if count == 5 {
            break;
        }
    }
    assert!(false, "CHecking!!!");
}
