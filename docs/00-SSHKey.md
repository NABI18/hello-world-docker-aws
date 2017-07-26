[Back to Top](../README.md)

# Setup a Key Pair for SSH access to GitHub and AWS EC2 Instances
Setup an SSH key for your operating system using the instructions on 
[GitHub Help on Generating a new SSH Key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/).

## How to securely put your Public key into your clipboard:

### On Mac OSX

`pbcopy < ~/.ssh/id_rsa.pub`

### On Windows in GitBash
`clip < ~/.ssh/id_rsa.pub`

### On Linux

```shell
# on linux open the key in an editor and copy to clipboard
# prefer `vim` over `cat` to prevent public key from being displayed in bash history
vim ~/.ssh/id_rsa.pub
    
# exit editor using `:q!` (without quotes to prevent saving any accidental edits)
```

---
## Resources

 * [GitHub Help on Generating a new SSH Key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) 

**Next:** [Set yourself up in AWS](01-AwsAccount.md)