# @version ^0.3.1

struct Tensor:
	data: DynArray[DynArray[DynArray[decimal, 128], 128], 128]

interface ApeTorch:
	def add(Tensor, Tensor) -> Tensor: pure
	def add(Tensor, Tensor) -> Tensor: pure
	def add(Tensor, Tensor) -> Tensor: pure
	def add(Tensor, Tensor) -> Tensor: pure
	def add(Tensor, Tensor) -> Tensor: pure
	def add(Tensor, Tensor) -> Tensor: pure
