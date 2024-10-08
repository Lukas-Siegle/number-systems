<script lang="ts">
    import { writable } from 'svelte/store';
    let current_number: number = 0
    let current_number_bin: string = "0"
    let current_number_hex: string = "0"

    function decimalToBinary(num: number) {
        return (num >>> 0).toString(2);
    }

    function dec2Hex(num: number) {
        return Math.abs(num).toString(16);
    }

    function add() {
        current_number += 1
        updateConversions()
    }

    function reset() {
        current_number = 0
        updateConversions()
    }

    function sub() {
        current_number -= 1
        updateConversions()
    }

    function updateConversions() {
        current_number_bin = decimalToBinary(current_number)
        current_number_hex = dec2Hex(current_number)
    }
</script>

<div class="max-w-md mx-auto mt-10 p-6 bg-white rounded-lg shadow-md">
    <div class="flex justify-center space-x-4 mb-6">
        <button on:click={add} class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors">+</button>
        <button on:click={reset} class="px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600 transition-colors">Reset</button>
        <button on:click={sub} class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors">-</button>
    </div>
    <div class="space-y-4">
        <div class="bg-gray-100 p-4 rounded-md">
            <p class="text-sm font-medium text-gray-500 mb-1">Decimal:</p>
            <p class="text-2xl font-bold"><input  class="bg-gray-100 border-none focus:outline-none focus:ring-0 active:outline-none" type="text" bind:value={current_number}></p>
        </div>
        <div class="bg-gray-100 p-4 rounded-md">
            <p class="text-sm font-medium text-gray-500 mb-1">Binary:</p>
            <p class="text-2xl font-bold">0b<input class="bg-gray-100 border-none focus:outline-none focus:ring-0 active:outline-none"type="text" bind:value={current_number_bin}></p>
        </div>
        <div class="bg-gray-100 p-4 rounded-md">
            <p class="text-sm font-medium text-gray-500 mb-1">Hexadecimal:</p>
            <p class="text-2xl font-bold">0x<input class="bg-gray-100 border-none focus:outline-none focus:ring-0 active:outline-none" type="text" bind:value={current_number_hex}></p>
        </div>
    </div>
</div>