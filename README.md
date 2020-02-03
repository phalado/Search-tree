# Search-tree - Open source search binary tree and bi-dimensional tree.

[![Forks][forks-shield]][forks-url] [![Stars][stars-shield]][stars-url] [![Issues][issues-shield]][issues-url] [![Inline docs][docs-shield]][docs-url] [![Twitter][twitter-shield]][twitter-url]

Search tree is an open-source binary and bi-dimensional tree gem for ruby.
For more information about why and how it was done visit my [article][article-url] in [Medium][medium-phalado].

<p align="center">
    <a href="https://github.com/phalado/Search-tree/issues">Report Bug</a>
    -  <a href="https://github.com/phalado/Search-tree/issues">Request Feature</a>
</p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Install and Usage](#install-and-usage)
* [Available Methods](#avaiable-methods)
  * [New node](#new-node)
  * [Search](#search)
  * [Search node](#search_node)
  * [Edit node](#edit_node)
  * [Delete node](#delete-node)
  * [Print tree](#print-tree)
  * [Number of nodes](#number-of-nodes)
  * [Get depth](#get-depth)
  * [Is balanced](#is-balanced)
  * [Balance](#balance)
  * [Get nodes](#get-nodes)
  * [New balance nodes](#new-balance-nodes)
  * [New node balanced](#new-node-balanced)
  * [Load file](#load-file)
  * [Save file](#save-file)
* [Author and Contribution](#author-and-contribution)
* [License](#license)
* [Future Works](#future-works)

## Install and Usage

Download the [gem file][gem-file] and use the following command to install:
```bash
gem install search_tree-[version].gem
```
After installing add
```ruby
 require 'search_tree'
 ```
  in your code and you can use its methods.

## Available Methods

First, you have to create a new tree using the ``BinaryTree`` class, as for example below:

```ruby
t = BinaryTree.new
```
In the ``initialize`` method the **root** variable is defined as *nil*.

### New node
```ruby
new_node(node, x, *args)
```
This method is used to create a new node in the tree. It receives the **node** where the search begins, **x** as the search parameter and the pointer **args** that will receive all the other arguments added to the node.

### Search
```ruby
search(x, node = @root)
```
Returns *true* if, starting at the passed **node**, it finds a node with the search parameter **x** and *false* if it finds a *nil*.

### Search node
```ruby
search_node(x, node = @root)
```
Like the previus one but instead of returning *true* or *false* returns the pointer to the node with search parameter **x** or *nil*.

### Edit node
```ruby
edit_node(x, *args)
```
Locate the node with search parameter **x** and changer its *arguments* for the ones in **args**, if this node existis.

### Delete node
```ruby
delete_node(x)
```
Delete the node with the dearch parameter **x**, if exists.

### Print tree
```ruby
print_tree(node = @root)
```
Print the tree, or sub-tree starting at the passed **node**, in crescent search parameter order.

### Number of nodes
```ruby
number_nodes(node = @root)
```
Return the number of nodes in the tree, or sub-tree starting at the passed **node**.

### Get depth
```ruby
get_depth(node = @root, depth = 1, maxdepth = 0)
```
Return the depth of the tree, or sub-tree starting at the passed **node**. The **depth** and **maxdepth** are used as helpers inside the method.

### Is balanced
```ruby
is_balanced?
```
Return *true* if the number of nodes is smaller than ``2 ^ (depth - 1)`` and bigger than ``2 ^ depth`` and *false* otherwise.

### Balance
```ruby
balance
```
Balance the tree unless ``is_balanced?`` returns *true*.

### Get nodes
```ruby
get_nodes(nodes, node = @root)
```
Return the array **nodes** with all the nodes in the crescent search parameter order in the tree or sub-tree starting at the passed **node**. Used to balance the tree.

### New balance nodes
```ruby
new_balance_nodes(nodes, newroot = @root)
```
Used to create a new node with the array **nodes** received in the ``get_nodes`` method.

### New node balanced
```ruby
new_node_balanced(node, x, *args)
```
Create a new node and balance the tree.

### Load file
```ruby
load_file(file)
```
Create a tree with the data inside a file. The search parameter will always be a string.

### Save file
```ruby
save_file(file)
```
Create a file with the data in the tree.

## Author and Contribution

Add me at [linkedin][linkedin-url], send me an [email][phalado@gmail.com], visit my [twitter][twitter-url], [medium][medium-phalado] and [portfolio][my-portfolio].

Feel free to contribute with pull requests but, for major changes, please open an issue first.

## License

Coming soon

## Future works

Already started a load file and a save file methods.

Have a big ambition to create the bi-dimensional tree. I will do it in the next days.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[downloads-shield]: https://img.shields.io/github/downloads/phalado/Search-tree
[downloads-url]: https://github.com/ferreirati/mv-08-htmlcss-framework/graphs/contributors

[forks-shield]: https://img.shields.io/github/forks/phalado/Search-tree
[forks-url]: https://github.com/phalado/Search-tree/network/members

[stars-shield]: https://img.shields.io/github/stars/phalado/Search-tree
[stars-url]: https://github.com/phalado/Search-tree/stargazers

[issues-shield]: https://img.shields.io/github/issues/phalado/Search-tree
[issues-url]: https://github.com/phalado/Search-tree/issues

[docs-shield]: http://inch-ci.org/github/phalado/Search-tree.svg?branch=master
[docs-url]: http://inch-ci.org/github/phalado/Search-tree

[twitter-shield]: https://img.shields.io/twitter/url?url=https%3A%2F%2Fgithub.com%2Fphalado%2FSearch-tree%2F
[twitter-url]: https://twitter.com/Phalado
[article-url]: https://medium.com/p/bdfe7069be2d/
[medium-phalado]: https://medium.com/@phalado
[gem-file]: https://drive.google.com/file/d/1emVISdDfuqisPSIYzv8qKCvVjo8gJdwT/view?usp=sharing
[linkedin-url]: https://www.linkedin.com/in/raphael-cordeiro/
[my-portfolio]: https://phalado.github.io/

[product-screenshot]: images/screenshot.png