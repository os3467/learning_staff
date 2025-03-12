Hi

'''python
def reverseText(text):
    words = text.split()
    return " ".join(reversed(words))

def main():
    text = input("Enter a text: ")
    print("Reversed text: ", reverseText(text))

if __name__ == "__main__":
    main()
'''
