using Toybox.Math;

module utils {
	var hexSymbols = "0123456789ABCDEF".toCharArray();
	
	/*
	 * converts a number to a two hex digit string.
	 */
	function toHex(number) {
		var a = (number / 16).toNumber();
		var rest = number % 16;
		return hexSymbols[a] + hexSymbols[rest];
	}
	
	function getHexLine(symbols, spacer) {
		var ret = getHexString() + spacer;
		for (var i = 1; i < symbols; i++) {
			ret += getHexString() + spacer;
		}
		ret = ret.substring(0, ret.length() - spacer.length());
		return ret;
	}

	function getHexString() {
		return hexSymbols[getRandomHex()].toString() + hexSymbols[getRandomHex()].toString();
	}
	
	function getRandomHex() {
		return Math.rand() % 16;
	}
	
	class ColorScheme {
		var data;
	
		function initialize() {
			self.data = {};
		}
		
		function set(symbol, color) {
			self.data[symbol] = color;
		}
		
		function get(symbol) {
			return self.data[symbol];
		}
	}
}