# Expandable Cells

<div align="center"><img src="expandable_cells_demo.gif"></div>

## Summary

Для того, чтобы сделать разворачивающиеся ячейки в своем проекте, необходимо:
- использовать [форк TableKit](https://github.com/TouchInstinct/TableKit)
- реализовать протокол ```Expandable``` для ячейки, которая должна разворачиваться 

В репозитории [ExpandableCellDemo-ios](https://github.com/TouchInstinct/ExpandableCellDemo-ios) вы можете посмотреть примеры реализации для ячеек, сверстанных на ```SnapKit```, ```PinLayout```, фреймах. Ячейка в примере содержит представление произвольной высоты (многострочный ```label```).

## TableKit

Для того, чтобы ячейки разворачивались/сворачивались плавно, без скачков и артефактов, необходимо, чтобы высота каждой ячейки на экране была подсчитана. Использование ```estimatedHeight``` ведет к вышеуказанным недостаткам. Форк содержит калькулятор высоты ```ExpandableCellHeightCalculator```, который необходимо использовать при инициализации ```TableDirector```:

```swift
private lazy var expandableCellHeightCalculator = ExpandableCellHeightCalculator(tableView: tableView)

override func viewDidLoad() {
    super.viewDidLoad()

    tableDirector = TableDirector(tableView: tableView,
                                  cellHeightCalculator: expandableCellHeightCalculator)

    ...
}
```

Благодаря этому точная высота подсчитывается автоматически для ячеек, сверстанных как с помощью AutoLayout, так и вручную. Также этот калькулятор позволяет менять высоту для конктретной ячейки.

Используйте этот калькулятор только на экранах, содержащих раскрывающиеся ячейки.

**Вы по-прежнему можете использовать ```defaultHeight``` в статических ячейках. Но не используйте ```estimatedHeight``` для self-sized ячеек, высота для таких ячеек будет подсчитана автоматически калькулятором высоты.**

## Верстка ячейки

Создайте представление, которое будет содержать все остальные.
```swift 
let containerView = UIView()
```

Добавьте его в ```contentView```. 

Если вы используете ```AutoLayout```, укажите высоту 0 для ```containerView```. Сохраните constraint высоты ```heightConstraint``` в ячейке. В дальнейшем мы будем менять его при сворачивании/разворачивании.

Важно:
- Если в вашей ячейке есть многострочные ```label'ы``` и вы верстаете с помощью ```AutoLayout```, указывайте ```label.preferredMaxLayoutWidth```. Это необходимо сделать не только для раскрывающейся ячейки, но и для всех остальных ячеек на экране, содержащем раскрывающиеся ячейки. **Если вы не укажете ```label.preferredMaxLayoutWidth```, высота ячейки будет подсчитана неверно.**

Поэтому лучше явно указывать ```preferredMaxLayoutWidth``` в зависимости от ширины ячейки.

```swift
override func layoutSubviews() {
    super.layoutSubviews()

    label.preferredMaxLayoutWidth = contentView.frame.width - 2 * textMargin
}
```

- Самое нижнее subview, содержащееся в ```containerView``` (которое будет показано в развернутом состоянии в самом низу), не должно иметь bottom constraint к ```containerView```. Это также помешает правильному расчету высоты.

- Установите ```clipsToBounds = true``` для ячейки, чтобы представления развернутого состояния не появлялись за границами ячейки. 

## Expandable

Для создания раскрывающейся необходимо сделать следующее.

1. ViewModel ячейки должна быть классом и реализовать протокол ```ExpandableCellViewModel```

```swift
class MyExpandableCellViewModel: ExpandableCellViewModel {

    var isCollapsed = true

}
```

Свойство ```isCollapsed``` будет меняться автоматически в зависимости от текущего состояния ячейки.

2. Реализуйте протокол ```ConfigurableCell``` для ячейки

Обратите внимание на статическое свойство ```layoutType```, добавленное в протокол ```ConfigurableCell``` форка. Свойство указывает на тип ```layout'а```, используемого для верстки ячейки. Возможные значения - ```.auto``` (AutoLayout, SnapKit), ```.manual``` (Frames, PinLayout). Тип влияет на механизм расчета высоты ячейки. Значение по умолчанию ```.auto```, так что если вы верстаете с помощью ```AutoLayout'а```, можете тип не указывать.

Необходимо сохранить ссылку на ```viewModel``` в ячейке.

```swift
final class ExpandableAutolayoutCell: UITableViewCell, ConfigurableCell {

    // MARK: - Properties

    private(set) weak var viewModel: MyExpandableCellViewModel?

    // MARK: - ConfigurableCell

    func configure(with viewModel: MyExpandableCellViewModel) {
        self.viewModel = viewModel

        ...
    }

    static var layoutType: LayoutType {
        return .auto
    }

}
```

3) Реализуйте протокол ```Expandable```. 

Вызовите метод ```initState()``` в конце ```configure(with _: MyExpandableCellViewModel)```. ```initState``` переводит ячейку в состояние, соответствующее полю ```isCollapsed``` ```viewModel'и```.

Реализуйте функцию ```configureAppearance(isCollapsed: Bool)```. Функция должна содержать изменения представления ячейки, которые происходят при разворачивании/сворачивании.

Измените constraint высоты container'а в зависимости от свойства isCollapsed. В данном примере в развернутом состоянии у нас показывается ```UILabel``` произвольной длины (numberOfLines = 0). Чтобы получить высоту для развернутого состояния, берем ```label.frame.maxY```. Также можете добавить произвольный ```margin``` снизу. Калькулятор высоты его учтет.

Меняйте цвет/прозрачноть и все, что должно меняться при разворачивании/сворачивании. Все изменения, описанные в ```configureAppearance```, будут автоматически анимироваться.

```swift
final class ExpandableAutolayoutCell: UITableViewCell, ConfigurableCell, Expandable {

    // MARK: - ConfigurableCell

    func configure(with viewModel: MyExpandableCellViewModel) {

        ...


        initState()
    }

    // MARK: - Expandable

    override func configureAppearance(isCollapsed: Bool) {
        guard let viewModel = viewModel else {
            return
        }

        heightConstraint?.layoutConstraints.first?.constant = isCollapsed
            ? BaseExpandableCell.collapsedHeight
            : label.frame.maxY + BaseExpandableCell.bottomMargin

        containerView.backgroundColor = isCollapsed ? viewModel.collapsedColor : viewModel.expandedColor

        label.alpha = isCollapsed ? 0 : 1
    }

}
```

4) Меняйте состояние ячейки

Создайте обработчик тапа для свернутого представления ячейки. Вызовите в нем метод ```toggleState()```.

Если ячейка свернута, она развернется и свойство isCollapsed viewModel'и изменится на false. Если ячейка развернута, она свернется и isCollapsed изменится на true.

Данный метод вызывает ```configureAppearance(isCollapsed: Bool)``` и обновляет таблицу.