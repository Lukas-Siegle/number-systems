<script lang="ts">
	import { get, writable, type Writable } from 'svelte/store';
	const current_number_dec: Writable<string> = writable('0');
	const current_number_bin: Writable<string> = writable('0');
	const current_number_hex: Writable<string> = writable('0');
	const counting: Writable<boolean> = writable(false);
    let interval: any
	function decimalToBinary(num: string): string {
		return BigInt(num).toString(2);
	}

	function decimalToHex(num: string): string {
		return BigInt(num).toString(16);
	}

	function binaryToDecimal(bin: string): string {
		return BigInt('0b' + bin).toString(10);
	}

	function binaryToHex(bin: string): string {
		return BigInt('0b' + bin).toString(16);
	}

	function hexToDecimal(hex: string): string {
		return BigInt('0x' + hex).toString(10);
	}

	function hexToBinary(hex: string): string {
		return BigInt('0x' + hex).toString(2);
	}

	counting.subscribe((isCounting) => {
		if (isCounting) {
			interval = setInterval(() => {
				incrementDecimal();
			}, 500);
		} else {
            console.log("clear")
			clearInterval(interval);
		}
	});

	current_number_dec.subscribe((value) => {
		if (value.length == 0) {
			value = '0';
		}
		let filtered: string = value.replace(/[^0-9]/gi, '');
		current_number_dec.set(filtered);
		current_number_bin.set(decimalToBinary(filtered));
		current_number_hex.set(decimalToHex(filtered));
	});

	current_number_bin.subscribe((value) => {
		if (value.length == 0) {
			value = '0';
		}
		let filtered: string = value.replace(/[^0-1]/gi, '');
		current_number_bin.set(filtered);
		current_number_hex.set(binaryToHex(filtered));
		current_number_dec.set(binaryToDecimal(filtered));
	});

	current_number_hex.subscribe((value) => {
		if (value.length == 0) {
			value = '0';
		}
		let filtered: string = value.replace(/[^0-9A-F]/gi, '').toUpperCase();
		current_number_hex.set(filtered);
		current_number_bin.set(hexToBinary(filtered));
		current_number_dec.set(hexToDecimal(filtered));
	});

	function incrementDecimal() {
		current_number_dec.update((n) => (BigInt(n) + BigInt(1)).toString());
	}

	function resetDecimal() {
		current_number_dec.set('0');
	}

	function decrementDecimal() {
		current_number_dec.update((n) => (BigInt(n) - BigInt(1)).toString());
	}
</script>

<div class="max-w-md mx-auto mt-10 p-6 bg-white rounded-lg shadow-md">
	<div class="flex justify-center space-x-4 mb-6">
		<button
			on:click={incrementDecimal}
			class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors">+</button
		>
		<button
			on:click={resetDecimal}
			class="px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600 transition-colors"
			>Reset</button
		>
		<button
			on:click={decrementDecimal}
			class="px-4 py-2  bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors">-</button
		>
		<button
			on:click={() => {
				counting.set(!get(counting));
			}}
			class="px-4 py-2 {!$counting ? 'bg-blue-500' : 'bg-red-500'} w-20 {!$counting ? 'hover:bg-blue-600' : 'bg-red-700'} text-white rounded transition-colors"
			>{#if $counting}
				Stop
			{:else}
				Count
			{/if}</button
		>
	</div>
	<div class="space-y-4">
		<div class="bg-gray-100 p-4 rounded-md">
			<p class="text-sm font-medium text-gray-500 mb-1">Decimal:</p>
			<p class="text-2xl font-bold border-solid border-gray-200 border-b">
				<input
					type="text"
					class="bg-gray-100 border-none focus:outline-none focus:ring-0 active:outline-none"
					bind:value={$current_number_dec}
				/>
			</p>
		</div>
		<div class="bg-gray-100 p-4 rounded-md">
			<p class="text-sm font-medium text-gray-500 mb-1">Binary:</p>
			<p class="text-2xl font-bold border-solid border-gray-200 border-b">
				0b<input
					type="text"
					class="bg-gray-100 border-none focus:outline-none focus:ring-0 active:outline-none"
					bind:value={$current_number_bin}
				/>
			</p>
		</div>
		<div class="bg-gray-100 p-4 rounded-md">
			<p class="text-sm font-medium text-gray-500 mb-1">Hexadecimal:</p>
			<p class="text-2xl font-bold border-solid border-gray-200 border-b">
				0x<input
					type="text"
					class="bg-gray-100 border-none focus:outline-none focus:ring-0 active:outline-none"
					bind:value={$current_number_hex}
				/>
			</p>
		</div>
	</div>
</div>
