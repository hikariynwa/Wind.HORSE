import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "button", "hiddenInput"]

  connect() {
    this.buttonTarget.addEventListener('click', this.toggleDropdown.bind(this));
  }

  toggleDropdown() {
    this.dropdownTarget.classList.toggle('hidden');
  }

  selectOption(event) {
    // 選択肢の表示用
    const selectedText = event.target.textContent.trim();

    // 選択肢のdata-value属性に設定された値を持ってくる
    const selectedValue = event.target.getAttribute('data-value');

    // ボタンのテキストを選択した項目の表示用テキストに置き換える用
    this.buttonTarget.innerHTML = selectedText +
      '<svg class="-mr-1 ml-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">' +
      '<path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg>';

    // 隠しフィールドに選択された値をセットする。
    this.hiddenInputTarget.value = selectedValue;

    // ドロップダウンを閉じる
    this.toggleDropdown();
  }
}