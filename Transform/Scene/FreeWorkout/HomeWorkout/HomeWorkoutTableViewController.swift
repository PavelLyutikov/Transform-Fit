//
//  ViewController.swift
//  Transform
//
//  Created by Nikita Malevich on 9/23/20.
//

import UIKit

class HomeWorkoutTableViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    var choiceMuscle = UserDefaults.standard.integer(forKey: "choiceMuscle")
    var chosenExercises = UserDefaults.standard.array(forKey: "chosenExercises") as? [String]
    
    var openNextHomeWorkoutList = UserDefaults.standard.bool(forKey: "openNextHomeWorkoutList")
    var openBackHomeWorkoutList = UserDefaults.standard.bool(forKey: "openBackHomeWorkoutList")
    var currentWorkoutIndexList = UserDefaults.standard.integer(forKey: "currentWorkoutIndexList")

    @IBOutlet weak var transformTableView: UITableView!
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
    //Breats
    private let breats = [
        HomeWorkout(image: UIImage(named: "breast3")!, imageBackground: UIImage(named: "breatsImg3")!, text1: "Жим Свенда".localized(), text2: "ГРУДНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Движение кистей осуществляется перпендикулярно полу, кисти прижаты друг к другу. \n \n-Если нагрузка недостаточная используйте отягощение, зажав его между кистей.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBreats%2F3.mp4?alt=media&token=5096ca12-f361-47f8-9d4c-220a56e12668"),
        HomeWorkout(image: UIImage(named: "breast2")!, imageBackground: UIImage(named: "breatsImg2")!, text1: "Отжимания с узкой постановкой".localized(), text2: "ГРУДНЫЕ МЫШЦЫ, ТРИЦЕПС, ПЕРЕДНИЙ ПУЧОК ДЕЛЬТЫ".localized(), text3: "Примечание: \n \n-Выполнять упражнение в упрощенном варианте можно с колен, ладони держите близко друг к другу. \n \n-Локти старайтесь держать ближе к корпусу, корпус держите ровно на одной линии.".localized(), text4: "3 x 8", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBreats%2F2.mp4?alt=media&token=4f5ec731-ca01-4435-8833-07312d559ac7"),
        HomeWorkout(image: UIImage(named: "breast1")!, imageBackground: UIImage(named: "breatsImg1")!, text1: "Отжимания от пола".localized(), text2: "ГРУДНЫЕ МЫШЦЫ, ТРИЦЕПС, ПЕРЕДНИЙ ПУЧОК ДЕЛЬТЫ".localized(), text3: "Примечание: \n \n-Упражнение возможно выполнять с колен (упрощенный вариант). \n \n-Корпус держите ровно на одной линии, живот в напряжении. \n \n-Опускайтесь грудью вниз до угла 90 градусов в локтях.".localized(), text4: "3 x 10", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBreats%2F1.mp4?alt=media&token=824cd842-11f9-415e-9276-8955971facf1"),
        HomeWorkout(image: UIImage(named: "breast4")!, imageBackground: UIImage(named: "breatsImg4")!, text1: "Жим лёжа".localized(), text2: "ГРУДНЫЕ МЫШЦЫ, ТРИЦЕПС, ПЕРЕДНИЙ ПУЧОК ДЕЛЬТЫ".localized(), text3: "Примечание: \n \n-Угол в локтевых суставах 90 градусов - в нижней точке, лопатки сведены. \n \n-В верхней точке руки перпендикулярны полу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBreats%2F4.mp4?alt=media&token=35f9d87c-eef1-4087-8160-a3db7d97ee79"),
        HomeWorkout(image: UIImage(named: "breast5")!, imageBackground: UIImage(named: "breatsImg5")!, text1: "Сведение рук лёжа".localized(), text2: "ГРУДНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Локти немного согнуты, во время выполнения угол в локтях зафиксирован. \n \n-Грудная клетка раскрыта, если нагрузка недостаточная увеличьте вес отягощения.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBreats%2F5.mp4?alt=media&token=03e34fed-a746-4e9d-8024-a8126b0ae2a1"),
        HomeWorkout(image: UIImage(named: "breast6")!, imageBackground: UIImage(named: "breatsImg6")!, text1: "Пулловер от опоры".localized(), text2: "ГРУДНЫЕ МЫШЦЫ, ШИРОЧАЙШИЕ МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Локти немного согнуты, во время выполнения угол в локтях зафиксирован. \n \n-Опора на лопатки, работа осуществляется плечевыми суставами, не старайтесь поднять таз выше линии корпуса.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBreats%2F6.mp4?alt=media&token=9e971c36-0960-400c-9218-efe1fdd01553"),
        HomeWorkout(image: UIImage(named: "breast7")!, imageBackground: UIImage(named: "breatsImg7")!, text1: "Пулловер лёжа".localized(), text2: "ГРУДНЫЕ МЫШЦЫ, ШИРОЧАЙШИЕ МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Локти немного согнуты, во время выполнения угол в локтях зафиксирован. \n \n-Грудная клетка раскрыта, в нижней точке руки находятся на весу, делайте паузу в нижней точке.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBreats%2F7.mp4?alt=media&token=3b8b88e6-05c8-4eee-9aff-abb78a7f0711")]
    
    //Shoulder
    private let shoulder = [
        HomeWorkout(image: UIImage(named: "shoulder3")!, imageBackground: UIImage(named: "shoulderImg3")!, text1: "Жим Арнольда".localized(), text2: "ПЕРЕДНИЙ, СРЕДНИЙ ПУЧОК ДЕЛЬТЫ".localized(), text3: "Примечание: \n \n-Упражнение можно выполнять также стоя. \n \nПоясница прямая, в конечной точке руки находятся перпендикулярно полу, во время выполнения предплечья параллельны друг другу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FShoulder%2F3.mp4?alt=media&token=ee4c19ff-f731-4dfb-bab6-26a9cb0ca3d0"),
        HomeWorkout(image: UIImage(named: "shoulder2")!, imageBackground: UIImage(named: "shoulderImg2")!, text1: "Подъем рук перед собой".localized(), text2: "ПЕРЕДНИЙ ПУЧОК ДЕЛЬТЫ".localized(), text3: "Примечание: \n \n-Руки в локтях выпрямлены, в конечной точке руки находятся параллельно полу. Если нагрузки недостаточно используйте отягощения. \n \n-В верхней точке делайте небольшую паузу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FShoulder%2F2.mp4?alt=media&token=749c1592-9a74-4bc1-a103-cf893bae8dcb"),
        HomeWorkout(image: UIImage(named: "shoulder1")!, imageBackground: UIImage(named: "shoulderImg1")!, text1: "Вертикальные отжимания".localized(), text2: "ДЕЛЬТЫ, ТРИЦЕПС, МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Колени немного согнуты, во время выполнения угол в коленях зафиксирован. \n \n-Держите корпус ровно, поясница прямая, опускайтесь строго по вертикали вниз. \n \n-Вес тела перенесите на руки, опускайтесь до угла в локтях 90 градусов.".localized(), text4: "3 х 10", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FShoulder%2F1.mp4?alt=media&token=1e4e33ab-9bd8-4a81-996d-29dadbda1093"),
        HomeWorkout(image: UIImage(named: "shoulder4")!, imageBackground: UIImage(named: "shoulderImg4")!, text1: "Махи через стороны".localized(), text2: "СРЕДНИЙ ПУЧОК ДЕЛЬТЫ".localized(), text3: "Примечание: \n \n-Упражнение можно выполнять также стоя. \n \n-Локти немного согнуты, во время выполнения угол в локтях зафиксирован. \n \n-В верхней точке руки находятся параллельно полу, делайте паузу в верхней точке.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FShoulder%2F4.mp4?alt=media&token=c94ce0a8-7050-47f9-ac95-a8644bb5e47f"),
        HomeWorkout(image: UIImage(named: "shoulder5")!, imageBackground: UIImage(named: "shoulderImg5")!, text1: "Подъем рук сидя".localized(), text2: "ПЕРЕДНИЙ ПУЧОК ДЕЛЬТЫ".localized(), text3: "Примечание: \n \n-Упражнение можно выполнять также стоя. \n \n-Зафиксируйте руки в локтях, немного согнув их. В конечной точке руки находятся параллельно полу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FShoulder%2F5.mp4?alt=media&token=97b94ad7-e81b-4dce-aac5-99b826bd501d")]
    
    //Hand
    private let hand = [
        HomeWorkout(image: UIImage(named: "hand3")!, imageBackground: UIImage(named: "handImg3")!, text1: "Сгибание рук".localized(), text2: "БИЦЕПС".localized(), text3: "Примечание: \n \n-Спина прямая, локти держите параллельно корпусу, прижмите локти к телу. \n \n-В конечно точке доверните кисти рук на себя, также в обратном положении.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FHand%2F3.mp4?alt=media&token=d9b0cc01-3045-4c93-9d1f-8b4b9c0fb3fa"),
        HomeWorkout(image: UIImage(named: "hand2")!, imageBackground: UIImage(named: "handImg2")!, text1: "Отжимания с узкой постановкой".localized(), text2: "ТРИЦЕПС, ГРУДНЫЕ МЫШЦЫ, ПЕРЕДНИЙ ПУЧОК ДЕЛЬТЫ".localized(), text3: "Примечание: \n \n-Выполнять упражнение в упрощенном варианте можно с колен, ладони держите близко друг к другу. \n \n-Локти старайтесь держать ближе к корпусу, корпус держите ровно на одной линии.".localized(), text4: "3 x 10", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FHand%2F2.mp4?alt=media&token=3abed7e8-ac93-4e56-9ec3-7eb494d86e15"),
        HomeWorkout(image: UIImage(named: "hand1")!, imageBackground: UIImage(named: "handImg1")!, text1: "Вертикальные отжимания".localized(), text2: "ТРИЦЕПС (ПРИ ВЫПРЯМЛЕНИИ РУК), ПЛЕЧИ, МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Колени немного согнуты, во время выполнения угол в коленях зафиксирован. \n \n-Держите корпус ровно, поясница прямая, опускайтесь строго по вертикали вниз. \n \n-Вес тела перенесите на руки, опускайтесь до угла в локтях 90 градусов.".localized(), text4: "3 x 10", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FHand%2F1.mp4?alt=media&token=6db697b0-6ed7-4936-bf80-b7bba7acb7ba"),
        HomeWorkout(image: UIImage(named: "hand4")!, imageBackground: UIImage(named: "handImg4")!, text1: "Разгибание рук из-за головы".localized(), text2: "ТРИЦЕПС".localized(), text3: "Примечание: \n \n-Спина прямая, локти держите параллельно корпусу, прижмите локти к телу. \n \n-В конечно точке доверните кисти рук на себя, также в обратном положении.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FHand%2F4.mp4?alt=media&token=f575c4f4-e5c7-4bd0-aaaa-1b1f937845da"),
        HomeWorkout(image: UIImage(named: "hand5")!, imageBackground: UIImage(named: "handImg5")!, text1: "Разгибание руки в упоре".localized(), text2: "ТРИЦЕПС".localized(), text3: "Примечание: \n \n-Опора на одну руку, поясница прямая. \n \n-Плечо параллельно корпусу, локоть прижат к телу. \n \n-В конечной точке при разгибании сделайте паузу. \n \nКоличество повторений рекомендовано к выполнению на каждую руку.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FHand%2F5.mp4?alt=media&token=60aa0ee7-1332-43ec-8ef3-9dbde5e65ce0"),
        HomeWorkout(image: UIImage(named: "hand6")!, imageBackground: UIImage(named: "handImg6")!, text1: "Французский жим".localized(), text2: "ТРИЦЕПС".localized(), text3: "Примечание: \n \n-Спина прижата, локти направлены вверх. \n \n-Плечи зафиксированы чуть под углом. Работаем только предплечьем, не разводите локти в стороны, кисти зафиксированы. \n \n-В конечной точке руки находятся на весу, руки параллельно полу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FHand%2F6.mp4?alt=media&token=45f5913e-cfc2-484b-a050-a7397183afaa")]
    
    //Cor
    private let cor = [
        HomeWorkout(image: UIImage(named: "cor1")!, imageBackground: UIImage(named: "corImg1")!, text1: "Подъем ног толчком вверх".localized(), text2: "ПРЯМАЯ МЫШЦА ЖИВОТА".localized(), text3: "Примечание: \n \n-Выполняйте упражнение по возможности. Плавно опускайтесь вниз. \n \n-Не обязательно делать именно 20 повторений, делайте сколько получается.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FCor%2F1.mp4?alt=media&token=933a5679-7958-42a8-bf71-d37b57070afd"),
        HomeWorkout(image: UIImage(named: "cor2")!, imageBackground: UIImage(named: "corImg2")!, text1: "Скручивание".localized(), text2: "ПРЯМАЯ МЫШЦА ЖИВОТА".localized(), text3: "Примечание: \n \n-Руки за головой, локти направлены в стороны. Колени согнуты, угол в коленях 90 градусов. \n \n-Отрываем лопатки от пола и возвращаемся в исходное положение. \n \n-Поясница прижата к полу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FCor%2F2.mp4?alt=media&token=db57647e-cd5d-484c-b185-09adc1e42478"),
        HomeWorkout(image: UIImage(named: "cor3")!, imageBackground: UIImage(named: "corImg3")!, text1: "Скручивание по диагонали".localized(), text2: "ПРЯМАЯ МЫШЦА ЖИВОТА, КОСЫЕ МЫШЦЫ ПРЕССА".localized(), text3: "Примечание: \n \n-Руки за головой, локти направлены в стороны. Поясница прижата к полу. \n \n-Скручивайтесь до прикосновения колена с локтем.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FCor%2F3.mp4?alt=media&token=c63fad7f-4ed7-46ec-a31a-a038c1469d0c"),
        HomeWorkout(image: UIImage(named: "cor4")!, imageBackground: UIImage(named: "corImg4")!, text1: "Флажок".localized(), text2: "ПРЯМАЯ МЫШЦА ЖИВОТА".localized(), text3: "Примечание: \n \n-Поясница прямая, руки направленны параллельно полу, ноги с корпусом в складке под углом 90 градусов. \n \n-Если вы не можете выпрями ноги, можно немного согнуть ноги в коленях.".localized(), text4: "3 x 30 сек.".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FCor%2F4.mp4?alt=media&token=d5ee3901-00f9-43ae-9421-44ea2ceb36ef"),
        HomeWorkout(image: UIImage(named: "cor5")!, imageBackground: UIImage(named: "corImg5")!, text1: "Книжка".localized(), text2: "ПРЯМАЯ МЫШЦА ЖИВОТА".localized(), text3: "Примечание: \n \n-Колени немного согнуты, поясница прямая. \n \n-Поднимайте корпус и колени одновременно, нужно максимально скруглиться. \n \n-В нижней точке голень параллельна полу, если нет дискомфорта в пояснице. В пояснице не выгибаемся.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FCor%2F5.mp4?alt=media&token=5dcb4b9a-296a-4700-8211-2d1a0eb90d03"),
        HomeWorkout(image: UIImage(named: "cor6")!, imageBackground: UIImage(named: "corImg6")!, text1: "Планка".localized(), text2: "МЫШЦЫ КОРА, ПРЯМАЯ МЫШЦА ЖИВОТА".localized(), text3: "Примечание: \n \n-Мышцы пресса в напряжении, поясница прямая. Корпус ровный, колени выпрямлены. \n \n-Плечи не проваливаются, угол в локтях 90 градусов.".localized(), text4: "3 x 30 сек.".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FCor%2F6.mp4?alt=media&token=161fdb01-eee7-41d2-8e17-a0376c323b08")]
    
    //Foot
    private let foot = [
        HomeWorkout(image: UIImage(named: "foot1")!, imageBackground: UIImage(named: "footImg1")!, text1: "Гуд Морнинг".localized(), text2: "БИЦЕПС БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ, МЫШЦЫ СТАБИЛИЗАТОРЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Спина прямая. Шею не задирайте вверх. \n \n-Колени чуть согнуты, наклоняйтесь вниз, сохраняя ровную спину, ноги на ширине плеч.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F1.mp4?alt=media&token=a944c8e6-6fa7-43eb-9665-a69fb4c0b003"),
        HomeWorkout(image: UIImage(named: "foot2")!, imageBackground: UIImage(named: "footImg2")!, text1: "Румынская тяга по одной ноге".localized(), text2: "БИЦЕПС БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ, МЫШЦЫ СТАБИЛИЗАТОРЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Колени чуть согнуты. Спина прямая, взгляд вниз. Одна нога отставлена чуть назад. \n \n-Движение рук происходит перпендикулярно полу, к передней ноге. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F2.mp4?alt=media&token=509cb1b9-fe34-4346-b321-32c5cc936f4d"),
        HomeWorkout(image: UIImage(named: "foot3")!, imageBackground: UIImage(named: "footImg3")!, text1: "Гуд Морнинг по одной ноге".localized(), text2: "БИЦЕПС БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ, МЫШЦЫ СТАБИЛИЗАТОРЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Поясница прямая, взгляд вниз. Старайтесь выпрямить все тело в одну линию, параллельно полу.  \n \n-Для сохранения равновесия согните опорную ногу в колене. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 12", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F3.mp4?alt=media&token=614d1ce0-1efb-466d-8067-5089947e4d02"),
        HomeWorkout(image: UIImage(named: "foot4")!, imageBackground: UIImage(named: "footImg4")!, text1: "Подъем на носки".localized(), text2: "ИКРОНОЖНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-В случае необходимости вы можете использовать отягощение, также для усиления нагрузки, можете подложить опору под носки ног.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F4.mp4?alt=media&token=a79827d3-88e1-4514-884d-2401dac9bc78"),
        HomeWorkout(image: UIImage(named: "foot5")!, imageBackground: UIImage(named: "footImg5")!, text1: "Подъем на носки по одной ноге".localized(), text2: "ИКРОНОЖНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-В случае необходимости вы можете использовать отягощение, также для усиления нагрузки, можете подложить опору под носки ног. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F5.mp4?alt=media&token=0d1b2a9d-63ad-4c2c-b86b-83331bad9d25"),
        HomeWorkout(image: UIImage(named: "foot6")!, imageBackground: UIImage(named: "footImg6")!, text1: "Приседания Плие".localized(), text2: "ВНУТРЕННЯЯ, ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА".localized(), text3: "Примечание: \n \n-Носки развернуты на 45 градусов. Опускайтесь вниз до параллели с полом, колени сонаправлены с носками. \n \n-Поясница прямая.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F6.mp4?alt=media&token=ded38ff2-57ac-4057-98c7-67936d8b4f02"),
        HomeWorkout(image: UIImage(named: "foot7")!, imageBackground: UIImage(named: "footImg7")!, text1: "Sisi приседания".localized(), text2: "ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА".localized(), text3: "Примечание: \n \n-Корпус ровный. Наклоняйтесь назад до предела своих возможностей, растягивая переднюю поверхность бедра, не допуская отрыва колен от пола. \n \n-Мышцы живота напряжены.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F7.mp4?alt=media&token=81018ec5-f51e-4f50-8681-5bc03d55485c"),
        HomeWorkout(image: UIImage(named: "foot8")!, imageBackground: UIImage(named: "footImg8")!, text1: "Приведение бедра".localized(), text2: "ПРИВОДЯЩИЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Поясница прямая, опора на тазовую кость. \n \n-Рабочая нога выпрямлена в колене, в верхней точке фиксируйте ногу. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F8.mp4?alt=media&token=a0602065-4192-4509-be42-1a3b2d442f93"),
        HomeWorkout(image: UIImage(named: "foot9")!, imageBackground: UIImage(named: "footImg9")!, text1: "Сведение ног лёжа на спине".localized(), text2: "ПРИВОДЯЩИЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Колени могут быть чуть согнуты, во время выполнения угол в колене зафиксирован. \n \n-Спина и лопатки прижаты, отводите ноги в стороны до придела. Работайте в своей амплитуде, без резких движений.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F9.mp4?alt=media&token=c2a8c997-8592-4347-a661-021d5eac4b72"),
        HomeWorkout(image: UIImage(named: "foot10")!, imageBackground: UIImage(named: "footImg10")!, text1: "Махи лёжа по одной ноге".localized(), text2: "ПРИВОДЯЩИЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Таз и спина прижаты к полу. \n \n-Выпрямите рабочую ногу в колене. При опускании ноги избегайте вращения корпуса вслед за ногой. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F10.mp4?alt=media&token=ed66e06d-a843-48fa-807a-776f9cb2181c"),
        HomeWorkout(image: UIImage(named: "foot11")!, imageBackground: UIImage(named: "footImg11")!, text1: "Сгибание бедра по одной ноге".localized(), text2: "БИЦЕПС БЕДРА".localized(), text3: "Примечание: \n \n-Живот в напряжении, спина прямая, взгляд направлен вниз. \n \n-Бедро рабочей ноги на одной линии с корпусом, параллельно полу. Сгибайте колено до 90 градусов. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F11.mp4?alt=media&token=4a576c7a-8d43-4400-b568-6917cb7ee025"),
        HomeWorkout(image: UIImage(named: "foot12")!, imageBackground: UIImage(named: "footImg12")!, text1: "Классические приседания".localized(), text2: "ПЕРЕДНЯЯ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Ноги чуть шире плеч, носки сонаправлены с коленями, спина прямая, взгляд направлен вперёд или вверх. \n \n-Опускайтесь вниз до параллели с полом. Колени не должны выходить за носки.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F12.mp4?alt=media&token=2d433021-8078-41b2-a1f7-3c067e0f0c73"),
        HomeWorkout(image: UIImage(named: "foot13")!, imageBackground: UIImage(named: "footImg13")!, text1: "Выпады назад".localized(), text2: "ПЕРЕДНЯЯ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-В нижней точке угол в коленях 90 градусов. Корпус наклонен чуть вперед, живот в напряжении, спина прямая, взгляд направлен вперёд или вверх. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F13.mp4?alt=media&token=cd56956b-16ef-405c-b925-a41e604b2436"),
        HomeWorkout(image: UIImage(named: "foot14")!, imageBackground: UIImage(named: "footImg14")!, text1: "Выпады на месте".localized(), text2: "ПЕРЕДНЯЯ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-В нижней точке угол в коленях 90 градусов. Корпус наклонен чуть вперед, живот в напряжении, спина прямая, взгляд направлен вперёд или вверх. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F14.mp4?alt=media&token=c6f500f0-81d2-4660-80d8-308f1a8c5a0a"),
        HomeWorkout(image: UIImage(named: "foot15")!, imageBackground: UIImage(named: "footImg15")!, text1: "Фронтальный присед".localized(), text2: "ПЕРЕДНЯЯ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Ноги на ширине плеч, носки сонаправлены с коленями, спина прямая, взгляд направлен вперёд или вверх. \n \n-Опускайтесь вниз до параллели с полом. Колени не должны выходить за носки.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F15.mp4?alt=media&token=6b38a192-c49f-44c1-944a-a054ee6101d4"),
        HomeWorkout(image: UIImage(named: "foot16")!, imageBackground: UIImage(named: "footImg16")!, text1: "Болгарские выпады".localized(), text2: "ПЕРЕДНЯЯ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Спина прямая, взгляд направлен вперёд или вверх. \n \n-Опускайтесь до угла в колене передней ноги 90 градусов, колено сонаправлено ступне. Избегайте завала колена. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F16.mp4?alt=media&token=cc78affb-858f-4160-8946-2bbb6e9ee06e"),
        HomeWorkout(image: UIImage(named: "foot18")!, imageBackground: UIImage(named: "footImg18")!, text1: "Выпады".localized(), text2: "ПЕРЕДНЯЯ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Спина прямая, взгляд направлен вперёд или вверх. \n \n-В нижней точке угол в коленях 90 градусов, не упирайтесь коленом задней ноги в пол, оно должно быть в минимальном расстоянии от пола. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F18.mp4?alt=media&token=8173dd8e-8995-454c-b555-35ce9aeb6926"),
        HomeWorkout(image: UIImage(named: "foot19")!, imageBackground: UIImage(named: "footImg19")!, text1: "Подъемы на носки сидя".localized(), text2: "ИКРОНОЖНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Это упражнение подойдёт,тем у кого есть ограничения с коленями и спиной. \n \n-Также для усиления нагрузки вы можете подложить опору под носки ног.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F19.mp4?alt=media&token=e720669b-98c9-4da6-adbb-122486dc6709"),
        HomeWorkout(image: UIImage(named: "foot20")!, imageBackground: UIImage(named: "footImg20")!, text1: "Pistol приседания".localized(), text2: "ПЕРЕДНЯЯ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА".localized(), text3: "Примечание: \n \n-Старайтесь сесть как можно ниже вниз на опорную ногу, не заваливаясь в строну. \n \n-Другую ногу и руки держите вытянутыми, для сохранения баланса. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 5", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F20.mp4?alt=media&token=9fde24a9-c327-4b70-8c0b-a407fc1b723b"),
        HomeWorkout(image: UIImage(named: "foot21")!, imageBackground: UIImage(named: "footImg21")!, text1: "Боковые выпады".localized(), text2: "ПЕРЕДНЯЯ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА, МАЛАЯ И СРЕДНЯЯ ЯГОДИЧНЫЕ".localized(), text3: "Примечание: \n \n-Спина прямая, взгляд направлен вперёд или вверх. \n \n-В нижней точке угол в коленях 90 градусов, не упирайтесь коленом задней ноги в пол, оно должно быть в минимальном расстоянии от пола. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FFoot%2F21.mp4?alt=media&token=feb67c44-f6cf-4009-a374-2df0f35fa889")]
    
    //Back
    private let back = [
        HomeWorkout(image: UIImage(named: "back1")!, imageBackground: UIImage(named: "backImg1")!, text1: "Лодочка".localized(), text2: "МЫШЦЫ СТАБИЛИЗАТОРЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Отрывайте ноги и корпус от пола на сколько это возможно, шея расслаблена, не прогибайтесь в пояснице сильно. \n \n-Фиксируйтесь в верхней точке.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBack%2F1.mp4?alt=media&token=10b7fa9c-de6f-4498-a607-caee5b6a4489"),
        HomeWorkout(image: UIImage(named: "back2")!, imageBackground: UIImage(named: "backImg2")!, text1: "Вертикальные отжимания".localized(), text2: "МЫШЦЫ СПИНЫ, ТРИЦЕПС, ПЛЕЧИ".localized(), text3: "Примечание: \n \n-Колени немного согнуты, во время выполнения угол в коленях зафиксирован. \n \n-Держите корпус ровно, поясница прямая, опускайтесь строго по вертикали вниз. \n \n-Вес тела перенесите на руки, опускайтесь до угла в локтях 90 градусов.".localized(), text4: "3 x 10", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBack%2F2.mp4?alt=media&token=2f9a5e3c-bbe7-4128-8893-7df3e76932a2"),
        HomeWorkout(image: UIImage(named: "back3")!, imageBackground: UIImage(named: "backImg3")!, text1: "Лодочка со свидением лопаток".localized(), text2: "МЫШЦЫ СТАБИЛИЗАТОРЫ СПИНЫ, ШИРОЧАЙШИЕ МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Отрывайте корпус от пола на сколько это возможно, шея расслаблена, не прогибайтесь в пояснице сильно. \n \n-Осуществляйте движение локтями назад, фиксируйтесь в верхней точке.".localized(), text4: "3 x 12", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBack%2F3.mp4?alt=media&token=13f9e037-472d-4998-8899-c455a728d739"),
        HomeWorkout(image: UIImage(named: "back4")!, imageBackground: UIImage(named: "backImg4")!, text1: "Лодочка 2".localized(), text2: "СТАБИЛИЗАТОРЫ И РОМБОВИДНЫЕ МЫШЦЫ СПИНЫ, ЗАДНЯЯ ДЕЛЬТА".localized(), text3: "Примечание: \n \n-Отрывайте корпус от пола на сколько это возможно, шея расслаблена, не прогибайтесь в пояснице сильно. \n \n-Осуществляйте движение кистями назад, фиксируйтесь в верхней точке.".localized(), text4: "3 x 12", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBack%2F4.mp4?alt=media&token=6911c632-4be3-442a-9b91-845a1f10005d"),
        HomeWorkout(image: UIImage(named: "back5")!, imageBackground: UIImage(named: "backImg5")!, text1: "Тяга к поясу в наклоне".localized(), text2: "МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Колени чуть согнуты, спина прямая. \n \n-Движение кистей осуществляется вдоль бёдер, уводите локти за линию спины.".localized(), text4: "3 х 18", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBack%2F5.mp4?alt=media&token=f5ec3092-88b5-4cb1-96ba-93eec9eae4fa"),
        HomeWorkout(image: UIImage(named: "back6")!, imageBackground: UIImage(named: "backImg6")!, text1: "Пулловер".localized(), text2: "МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Локти немного согнуты, во время выполнения угол в локтях зафиксирован. \n \n-Опора на лопатки, работа осуществляется плечевыми суставами, не старайтесь поднять таз выше линии корпуса.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBack%2F6.mp4?alt=media&token=c52f0e05-a2e8-417e-ac3c-449858709f68"),
        HomeWorkout(image: UIImage(named: "back7")!, imageBackground: UIImage(named: "backImg7")!, text1: "Пулловер лёжа".localized(), text2: "МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Локти немного согнуты, во время выполнения угол в локтях зафиксирован. Грудная клетка раскрыта. \n \n-В нижней точке руки находятся на весу, делайте паузу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBack%2F7.mp4?alt=media&token=de97a0f9-8ea1-4813-9b7e-639d56b299ee"),
        HomeWorkout(image: UIImage(named: "back8")!, imageBackground: UIImage(named: "backImg8")!, text1: "Тяга к поясу в упоре".localized(), text2: "МЫШЦЫ СПИНЫ".localized(), text3: "Примечание: \n \n-Опорная нога завалена вперёд и немного согнута, спина прямая. \n \n-В нижней точке плечо завалено вниз, рука выпрямлена, в верхней точке угол в локте 90 градусов, уводите локоть за линию спины. \n \nКоличество повторений рекомендовано к выполнению на каждую руку.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FBack%2F8.mp4?alt=media&token=97dbb675-9cdb-4294-ad5b-78fdea6549d4")]
    
    //Glutes
    private let glutes = [
        HomeWorkout(image: UIImage(named: "glutes1")!, imageBackground: UIImage(named: "glutesImg1")!, text1: "Гуд Морнинг".localized(), text2: "ЯГОДИЧНЫЕ МЫШЦЫ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА".localized(), text3: "Примечание: \n \n-Спина прямая. Шею не задираем наверх. Колени чуть согнуты, наклоняйтесь вниз, сохраняя ровную спину, ноги на ширине плеч. \n \n-Также вы можете чувствовать мышцы спины, т.к они тоже включаются в работу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F1.mp4?alt=media&token=b8abbe8f-df18-4cdb-be2a-98764aa119cf"),
        HomeWorkout(image: UIImage(named: "glutes2")!, imageBackground: UIImage(named: "glutesImg2")!, text1: "Румынская тяга по одной ноге".localized(), text2: "ЯГОДИЧНЫЕ МЫШЦЫ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА".localized(), text3: "Примечание: \n \n-Колени чуть согнуты, спина прямая. Опускайтесь отводя таз назад, чувствуя натяжение задней поверхности бедра. \n \n-Также вы можете чувстовать мышцы спины, т.к они тоже включаются в работу. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F2.mp4?alt=media&token=82796e5a-b6f5-4e57-9575-29d6f04feb2f"),
        HomeWorkout(image: UIImage(named: "glutes3")!, imageBackground: UIImage(named: "glutesImg3")!, text1: "Гуд Морнинг по одной ноге".localized(), text2: "ЯГОДИЧНЫЕ МЫШЦЫ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА".localized(), text3: "Примечание: \n \n-Поясница прямая, старайтесь выпрямить все тело в одну линию. \n \n-Для сохранения равновесия согните опорную ногу в колене. \n \n-Также вы можете чувстовать мышцы спины, т.к они тоже включаются в работу. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 12", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F3.mp4?alt=media&token=f22d1ade-86b7-400b-bc3e-6d218b337d7d"),
        HomeWorkout(image: UIImage(named: "glutes4")!, imageBackground: UIImage(named: "glutesImg4")!, text1: "Махи вверх".localized(), text2: "ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Живот в напряжении, спина прямая, взгляд направлен вниз. \n \n-В верхней точке бедро рабочей ноги на одной линии с корпусом, параллельно полу, сгиб в колене 90 градусов. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F4.mp4?alt=media&token=31c653e3-eca8-4795-b07e-52250506e095"),
        HomeWorkout(image: UIImage(named: "glutes5")!, imageBackground: UIImage(named: "glutesImg5")!, text1: "Махи в бок".localized(), text2: "МАЛАЯ И СРЕДНЯЯ ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Живот в напряжении, спина прямая, взгляд направлен вниз. Угол в коленях 90 градусов. \n \n-Работайте в комфортной амплитуде. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F5.mp4?alt=media&token=cdd024f8-6336-46f5-86ec-0bc54e97d0b1"),
        HomeWorkout(image: UIImage(named: "glutes6")!, imageBackground: UIImage(named: "glutesImg6")!, text1: "Махи в бок из положения планки".localized(), text2: "МАЛАЯ И СРЕДНЯЯ ЯГОДИЧНЫЕ МЫШЦЫ, МЫШЦЫ КОРА".localized(), text3: "Примечание: \n \n-Старайтесь не проваливаться в плече опорной руки, корпус ровный, взгляд прямо, мышцы живота в напряжении. \n \n-Отводите бедро в сторону на столько на сколько это возможно. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F6.mp4?alt=media&token=17168a0d-f128-45d0-800b-9affe3250608"),
        HomeWorkout(image: UIImage(named: "glutes7")!, imageBackground: UIImage(named: "glutesImg7")!, text1: "Ягодичный мостик".localized(), text2: "БОЛЬШАЯ ЯГОДИЧНАЯ МЫШЦА".localized(), text3: "Примечание: \n \n-Опора на пятки, таз слегка подкручен на себя. Живот в напряжении. Спина прямая, поднимайте таз до прямой линии - бедра, корпус.".localized(), text4: "3 х 25", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F7.mp4?alt=media&token=6e1b4e8a-6ae6-4cfa-9fe8-5c545bd2038e"),
        HomeWorkout(image: UIImage(named: "glutes8")!, imageBackground: UIImage(named: "glutesImg8")!, text1: "Ягодичный мостик одной ногой".localized(), text2: "БОЛЬШАЯ ЯГОДИЧНАЯ МЫШЦА".localized(), text3: "Примечание: \n \n-Опора на пятку, таз слегка подкручен на себя. Живот в напряжении. Спина прямая, поднимайте таз до прямой линии - бедра, корпус. Верхняя нога перпендикулярно полу. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F8.mp4?alt=media&token=17657f6e-ff25-4813-85a1-758fead45ac2"),
        HomeWorkout(image: UIImage(named: "glutes9")!, imageBackground: UIImage(named: "glutesImg9")!, text1: "Махи в бок стоя".localized(), text2: "МАЛАЯ И СРЕДНЯЯ ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Корпус и опорная нога в одной плоскости, колено опорной ноги прямое. Поднимайте рабочую ногу невысоко, так чтобы корпус оставался ровным. \n \n-Если теряете равновесие, можете опереться о стену. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F9.mp4?alt=media&token=82e191f0-e580-4aff-b5e4-c7ef0a8f3f85"),
        HomeWorkout(image: UIImage(named: "glutes10")!, imageBackground: UIImage(named: "glutesImg10")!, text1: "Обратная экстензия".localized(), text2: "МЫШЦЫ СТАБИЛИЗАТОРЫ СПИНЫ, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Отрывайте бёдра от пола насколько это возможно, колени смотрят в стороны, шея расслаблена. \n \n-Не прогибайтесь в пояснице сильно, в верхней точке сжимайте ягодицы.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F10.mp4?alt=media&token=5c03443c-6e9d-4b2d-ae6b-e05635bc5f0e"),
        HomeWorkout(image: UIImage(named: "glutes11")!, imageBackground: UIImage(named: "glutesImg11")!, text1: "Приседания плие".localized(), text2: "ВНУТРЕННЯЯ, ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА".localized(), text3: "Примечание: \n \n-Ноги шире плеч, носки направлены в стороны, колени сонаправлены с носками, спина прямая. \n \n-Опускайтесь вниз до параллели с полом, угол в коленях 90 градусов.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F11.mp4?alt=media&token=d85edeab-783f-407b-b157-34be9e65bc02"),
        HomeWorkout(image: UIImage(named: "glutes12")!, imageBackground: UIImage(named: "glutesImg12")!, text1: "Махи в бок лёжа".localized(), text2: "МАЛАЯ И СРЕДНЯЯ ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Корпус ровный, живот в напряжении, не проваливаемся в плече, взгляд прямо, отводим бедро в сторону, но не задираем сильно высоко. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F12.mp4?alt=media&token=64cfba6f-c4cb-4683-aac3-1bc9b479cdc7"),
        HomeWorkout(image: UIImage(named: "glutes13")!, imageBackground: UIImage(named: "glutesImg13")!, text1: "Выпады на месте".localized(), text2: "ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Спина прямая, взгляд направлен вперёд или вверх. В нижней точке угол в коленях 90 градусов. \n \n-Колено должно быть  максимально близко к полу, но не касаться его. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F13.mp4?alt=media&token=c93606d5-3cff-499b-b324-4fbce886f99a"),
        HomeWorkout(image: UIImage(named: "glutes14")!, imageBackground: UIImage(named: "glutesImg14")!, text1: "Классические приседания".localized(), text2: "ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Ноги чуть шире плеч, колени сонаправлены с носками, спина прямая, взгляд направлен вперёд или вверх. \n \n-Опускайтесь вниз до параллели с полом. Колени не должны выходить за носки.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F14.mp4?alt=media&token=c4f3e00b-cdd9-4fca-95d7-93b68ef86340"),
        HomeWorkout(image: UIImage(named: "glutes15")!, imageBackground: UIImage(named: "glutesImg15")!, text1: "Выпады назад".localized(), text2: "ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-В нижней точке угол в коленях 90 градусов. Корпус наклонен чуть вперед, живот в напряжении, спина прямая, взгляд направлен вперёд или вверх. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F15.mp4?alt=media&token=27be8d5d-aa93-4e9d-bf09-656b2c1bde54"),
        HomeWorkout(image: UIImage(named: "glutes16")!, imageBackground: UIImage(named: "glutesImg16")!, text1: "Выпады на месте 2".localized(), text2: "ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-В нижней точке угол в коленях 90 градусов. Корпус наклонен чуть вперед, живот в напряжении, спина прямая, взгляд направлен вперёд или вверх. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F16.mp4?alt=media&token=21f0f6a7-8588-4458-8393-c1600c654002"),
        HomeWorkout(image: UIImage(named: "glutes17")!, imageBackground: UIImage(named: "glutesImg17")!, text1: "Фронтальный присед".localized(), text2: "ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Спина прямая, взгляд направлен вперёд или вверх. Колени сонаправлены с носками. \n \n-Бёдра стараемся опустить до параллели с полом. Колени не заваливаем во внутрь.".localized(), text4: "3 х 20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F17.mp4?alt=media&token=d3b7f2f2-645e-48e3-9a34-c0346f452e9f"),
        HomeWorkout(image: UIImage(named: "glutes18")!, imageBackground: UIImage(named: "glutesImg18")!, text1: "Болгарские выпады".localized(), text2: "ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА, ЯГОДИЧНЫЕ МЫШЦЫ".localized(), text3: "Примечание: \n \n-Спина прямая, взгляд направлен вперёд или вверх. \n \n-Старайтесь держать угол в колене передней ноги 90 градусов и не наваривайтесь на него. Носок задней ноги можно располагать по-другому. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 х 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F18.mp4?alt=media&token=9fd8397f-e598-4f7a-ad3d-24b38d1a1f74"),
        HomeWorkout(image: UIImage(named: "glutes20")!, imageBackground: UIImage(named: "glutesImg20")!, text1: "Диагональные выпады".localized(), text2: "ЗАДНЯЯ, ПЕРЕДНЯЯ ПОВЕРХНОСТЬ БЕДРА, МАЛАЯ И СРЕДНЯЯ ЯГОДИЧНЫЕ".localized(), text3: "Примечание: \n \n-Спина прямая, взгляд направлен вперёд или вверх. В нижней точке угол в коленях 90 градусов. \n \n-Не упирайтесь коленом задней ноги в пол, оно должно быть в минимальном расстоянии от пола. \n \nКоличество повторений рекомендовано к выполнению на каждую ногу.".localized(), text4: "3 x 15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/HomeWorkout%2FGlutes%2F20.mp4?alt=media&token=1092ea35-c711-48b3-9cdd-c928e62cb243")]
    
    private var selectedTransform: HomeWorkout?

//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        backgroundImage.isHidden = false
        navigationController?.isNavigationBarHidden = true
        
        //TableViewPosition
        let positY: CGFloat!
        if totalSize.height >= 890 {
            positY = 85
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 85
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 65
        } else if totalSize.height <= 670 {
            positY = 65
        } else {
            positY = 85
        }
        transformTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positY)
        }
//        transformTableView.layer.zPosition = 5
        
        let customFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        customFooterView.backgroundColor = .clear
        
        self.transformTableView.tableFooterView = customFooterView
        
        
        setNavBarToTheView()
        
        dismissButton.addTarget(self, action: #selector(buttonDismiss), for: .touchUpInside)
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            if self.openNextHomeWorkoutList == true {
            UserDefaults.standard.set(false, forKey: "openNextHomeWorkoutList")
            self.nextWorkout()
            }
            if self.openBackHomeWorkoutList == true {
            UserDefaults.standard.set(false, forKey: "openBackHomeWorkoutList")
            self.backWorkout()
            }
        }
        
        //ads
        if !UserDefaults.standard.bool(forKey: "removeAdsPurchased") {
            setupIronSourceSdk()
            loadBanner()
        }
        
        spawnImageBackgroundTransition()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
//MARK: - IronSource
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: Int(self.view.frame.size.width), height: 50)
           IronSource.loadBanner(with: self, size: BNSize)
        UserDefaults.standard.set(true, forKey: "bannerLoaded")
    }
    func setupIronSourceSdk() {
        IronSource.setBannerDelegate(self)
        IronSource.add(self)
        
        IronSource.initWithAppKey(kAPPKEY)
    }
    func logFunctionName(string: String = #function) {
        print("IronSource Swift Demo App:"+string)
    }
    func destroyBanner() {
        if bannerView != nil {
            IronSource.destroyBanner(bannerView)
        }
    }
    
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "homeWorkoutBackground"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.1
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
    }
        return image
    }()
//MARK: - ImageBackgroundTransition
    lazy var imageBackgroundTransition: UIImageView = {
        var img = UIImageView()
        if totalSize.height >= 920 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransition12ProMax"))
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransition"))
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransition12"))
        } else if totalSize.height == 812 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransition12Mini"))
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransition7+"))
        } else if totalSize.height <= 670 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionMin"))
        } else {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransition12Mini"))
        }
        
        img.contentMode = .scaleAspectFit
        img.layer.zPosition = 7
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(0)
        }
        
        return img
    }()
//MARK: - spawnImageBackgroundTransition
    func spawnImageBackgroundTransition() {
        let indexPath = IndexPath(item: currentWorkoutIndexList + 1, section: 0)
        
        var countList = IndexPath()
        
        if choiceMuscle == 1 {
            countList = IndexPath(item: breats.count - 1, section: 0)
        } else if choiceMuscle == 2 {
            countList = IndexPath(item: shoulder.count - 1, section: 0)
        } else if choiceMuscle == 3 {
            countList = IndexPath(item: hand.count - 1, section: 0)
        } else if choiceMuscle == 4 {
            countList = IndexPath(item: cor.count - 1, section: 0)
        } else if choiceMuscle == 5 {
            countList = IndexPath(item: foot.count - 1, section: 0)
        } else if choiceMuscle == 6 {
            countList = IndexPath(item: back.count - 1, section: 0)
        } else if choiceMuscle == 7 {
            countList = IndexPath(item: glutes.count - 1, section: 0)
        }
        
        let countListBack = IndexPath(item: 2, section: 0)
        
        if indexPath <= countList {
            if openNextHomeWorkoutList == true {
                imageBackgroundTransition.isHidden = false
            }
        }
        if indexPath >= countListBack {
            if openBackHomeWorkoutList == true {
                imageBackgroundTransition.isHidden = false
            }
        }
    }
//MARK: - NextWorkout
     func nextWorkout() {
        let indexPath = IndexPath(item: currentWorkoutIndexList + 1, section: 0)
        
        var countList = IndexPath()
        
        if choiceMuscle == 1 {
            countList = IndexPath(item: breats.count - 1, section: 0)
        } else if choiceMuscle == 2 {
            countList = IndexPath(item: shoulder.count - 1, section: 0)
        } else if choiceMuscle == 3 {
            countList = IndexPath(item: hand.count - 1, section: 0)
        } else if choiceMuscle == 4 {
            countList = IndexPath(item: cor.count - 1, section: 0)
        } else if choiceMuscle == 5 {
            countList = IndexPath(item: foot.count - 1, section: 0)
        } else if choiceMuscle == 6 {
            countList = IndexPath(item: back.count - 1, section: 0)
        } else if choiceMuscle == 7 {
            countList = IndexPath(item: glutes.count - 1, section: 0)
        }
        
        
        if indexPath <= countList {
        
        UserDefaults.standard.set(indexPath.row, forKey: "currentWorkoutIndexList")

        destroyBanner()
            
        if choiceMuscle == 1 {
            selectedTransform = breats[indexPath.row]
        } else if choiceMuscle == 2 {
            selectedTransform = shoulder[indexPath.row]
        } else if choiceMuscle == 3 {
            selectedTransform = hand[indexPath.row]
        } else if choiceMuscle == 4 {
            selectedTransform = cor[indexPath.row]
        } else if choiceMuscle == 5 {
            selectedTransform = foot[indexPath.row]
        } else if choiceMuscle == 6 {
            selectedTransform = back[indexPath.row]
        } else if choiceMuscle == 7 {
            selectedTransform = glutes[indexPath.row]
        }
        
        UserDefaults.standard.set(true, forKey: "isOpenHomeWorkout")

        performSegue(withIdentifier: "homeWorkoutSegue", sender: nil)
        }
    }
//MARK: - BackWorkout
     func backWorkout() {
        let indexPath = IndexPath(item: currentWorkoutIndexList - 1, section: 0)
        
        let countList = IndexPath(item: 0, section: 0)
        
        if indexPath >= countList {
        
        UserDefaults.standard.set(indexPath.row, forKey: "currentWorkoutIndexList")

        destroyBanner()
            
        if choiceMuscle == 1 {
            selectedTransform = breats[indexPath.row]
        } else if choiceMuscle == 2 {
            selectedTransform = shoulder[indexPath.row]
        } else if choiceMuscle == 3 {
            selectedTransform = hand[indexPath.row]
        } else if choiceMuscle == 4 {
            selectedTransform = cor[indexPath.row]
        } else if choiceMuscle == 5 {
            selectedTransform = foot[indexPath.row]
        } else if choiceMuscle == 6 {
            selectedTransform = back[indexPath.row]
        } else if choiceMuscle == 7 {
            selectedTransform = glutes[indexPath.row]
        }
        
        UserDefaults.standard.set(true, forKey: "isOpenHomeWorkout")

        performSegue(withIdentifier: "homeWorkoutSegue", sender: nil)
        }
    }
//MARK: - SuccessImage
    lazy var succesImage: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "checked"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(80)
        }
        return img
    }()
//MARK: - DeletedWorkout
    lazy var deletedWorkoutImage: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "deletedWorkout"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(80)
        }
        return img
    }()
//MARK: - NavigationBar
    func setNavBarToTheView() {
        let positY: CGFloat!
        if totalSize.height >= 890 {
            positY = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 40
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 20
        } else if totalSize.height <= 670 {
            positY = 20
        } else {
            positY = 40
        }
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0 + positY, width: self.view.frame.size.width, height: 64.0))
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        navBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(navBar)
        
        
        let navItem = UINavigationItem()
        
        switch self.choiceMuscle {
        case 1:
            navItem.title = "Грудные мышцы".localized()
        case 2:
            navItem.title = "Мышцы плеч".localized()
        case 3:
            navItem.title = "Мышцы рук".localized()
        case 4:
            navItem.title = "Мышцы пресса".localized()
        case 5:
            navItem.title = "Мышцы ног".localized()
        case 6:
            navItem.title = "Мышцы спины".localized()
        case 7:
            navItem.title = "Ягодичные мышцы".localized()
        default:
            navItem.title = ""
        }
        
        
        navBar.setItems([navItem], animated: true)
    }
//MARK: Dismiss
    @objc lazy var dismissButton: UIButton = {

        let top: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 830 {
            top = 45
            trail = 15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            top = 25
            trail = 20
        } else if totalSize.height <= 670 {
            top = 25
            trail = 10
        } else {
            top = 45
            trail = 15
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "closeBlack"), for: .normal)
        btn.layer.zPosition = 4
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.trailing.equalToSuperview().inset(trail)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        return btn
    }()
    @objc func buttonDismiss(sender: UIButton) {

        destroyBanner()
        
        let vc = HomeWorkoutMenuViewController()
        vc.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
//MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? HomeWorkoutViewController else { return }

        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        controller.homeWorkout = selectedTransform
    }
//MARK: StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

//MARK: - TableView
extension HomeWorkoutTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if choiceMuscle == 2 {
            return shoulder.count
        } else if choiceMuscle == 3 {
            return hand.count
        } else if choiceMuscle == 4 {
            return cor.count
        } else if choiceMuscle == 5 {
            return foot.count
        } else if choiceMuscle == 6 {
            return back.count
        } else if choiceMuscle == 7 {
            return glutes.count
        }
        return breats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transformCell") as? HomeWorkoutTableViewCell else { return UITableViewCell() }
        
        let fontSize: CGFloat!
        let fontSizeLb1: CGFloat!
        if totalSize.height >= 890 {
            fontSize = 16
            fontSizeLb1 = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            fontSize = 15
            fontSizeLb1 = 18
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            fontSize = 15
            fontSizeLb1 = 19
        } else if totalSize.height <= 670 {
            fontSize = 15
            fontSizeLb1 = 17
        } else {
            fontSize = 15
            fontSizeLb1 = 17
        }
        
        if choiceMuscle == 1 {
            let transform = breats[indexPath.row]
            cell.homeWorkoutImageView.image = transform.image
            cell.homeWorkoutLabel1.text = transform.text1
            cell.homeWorkoutLabel1.font = UIFont.systemFont(ofSize: fontSizeLb1)
            cell.homeWorkoutLabel2.text = transform.text2
            cell.homeWorkoutLabel2.font = UIFont.systemFont(ofSize: fontSize)
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 2 {
            let transform = shoulder[indexPath.row]
            
            cell.homeWorkoutImageView.image = transform.image
            cell.homeWorkoutLabel1.text = transform.text1
            cell.homeWorkoutLabel1.font = UIFont.systemFont(ofSize: fontSizeLb1)
            cell.homeWorkoutLabel2.text = transform.text2
            cell.homeWorkoutLabel2.font = UIFont.systemFont(ofSize: fontSize)
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 3 {
            let transform = hand[indexPath.row]
            
            cell.homeWorkoutImageView.image = transform.image
            cell.homeWorkoutLabel1.text = transform.text1
            cell.homeWorkoutLabel1.font = UIFont.systemFont(ofSize: fontSizeLb1)
            cell.homeWorkoutLabel2.text = transform.text2
            cell.homeWorkoutLabel2.font = UIFont.systemFont(ofSize: fontSize)
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 4 {
            let transform = cor[indexPath.row]
            
            cell.homeWorkoutImageView.image = transform.image
            cell.homeWorkoutLabel1.text = transform.text1
            cell.homeWorkoutLabel1.font = UIFont.systemFont(ofSize: fontSizeLb1)
            cell.homeWorkoutLabel2.text = transform.text2
            cell.homeWorkoutLabel2.font = UIFont.systemFont(ofSize: fontSize)
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 5 {
            let transform = foot[indexPath.row]
            
            cell.homeWorkoutImageView.image = transform.image
            cell.homeWorkoutLabel1.text = transform.text1
            cell.homeWorkoutLabel1.font = UIFont.systemFont(ofSize: fontSizeLb1)
            cell.homeWorkoutLabel2.text = transform.text2
            cell.homeWorkoutLabel2.font = UIFont.systemFont(ofSize: fontSize)
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 6 {
            let transform = back[indexPath.row]
            
            cell.homeWorkoutImageView.image = transform.image
            cell.homeWorkoutLabel1.text = transform.text1
            cell.homeWorkoutLabel1.font = UIFont.systemFont(ofSize: fontSizeLb1)
            cell.homeWorkoutLabel2.text = transform.text2
            cell.homeWorkoutLabel2.font = UIFont.systemFont(ofSize: fontSize)
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 7 {
            let transform = glutes[indexPath.row]
            
            cell.homeWorkoutImageView.image = transform.image
            cell.homeWorkoutLabel1.text = transform.text1
            cell.homeWorkoutLabel1.font = UIFont.systemFont(ofSize: fontSizeLb1)
            cell.homeWorkoutLabel2.text = transform.text2
            cell.homeWorkoutLabel2.font = UIFont.systemFont(ofSize: fontSize)
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        destroyBanner()
        
        if choiceMuscle == 1 {
            selectedTransform = breats[indexPath.row]
        } else if choiceMuscle == 2 {
            selectedTransform = shoulder[indexPath.row]
        } else if choiceMuscle == 3 {
            selectedTransform = hand[indexPath.row]
        } else if choiceMuscle == 4 {
            selectedTransform = cor[indexPath.row]
        } else if choiceMuscle == 5 {
            selectedTransform = foot[indexPath.row]
        } else if choiceMuscle == 6 {
            selectedTransform = back[indexPath.row]
        } else if choiceMuscle == 7 {
            selectedTransform = glutes[indexPath.row]
        }
        
        UserDefaults.standard.set(indexPath.row, forKey: "currentWorkoutIndexList")
        
        UserDefaults.standard.set(true, forKey: "isOpenHomeWorkout")

        performSegue(withIdentifier: "homeWorkoutSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedExercise: HomeWorkout
        
        switch self.choiceMuscle {
        case 1:
            selectedExercise = self.breats[indexPath.row]
        case 2:
            selectedExercise = self.shoulder[indexPath.row]
        case 3:
            selectedExercise = self.hand[indexPath.row]
        case 4:
            selectedExercise = self.cor[indexPath.row]
        case 5:
            selectedExercise = self.foot[indexPath.row]
        case 6:
            selectedExercise = self.back[indexPath.row]
        case 7:
            selectedExercise = self.glutes[indexPath.row]
        default:
            selectedExercise = self.breats[indexPath.row]
        }
        
        let isChosen = chosenExercises?.contains(where: { $0 == selectedExercise.video })
        
        let chosenAction = UIContextualAction(style: .normal, title: "", handler: { (action, view, boolValue) in
            if isChosen == nil {
                self.chosenExercises = [String]()
            }
            
            if isChosen == true {
                guard let chosenIndex = self.chosenExercises?.firstIndex(where: { $0 == selectedExercise.video }) else { return }
                
                self.deletedWorkoutImage.isHidden = false
                self.deletedWorkoutImage.zoomInInfo()
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.deletedWorkoutImage.zoomOutInfo()
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.deletedWorkoutImage.isHidden = true
                    }
                }
                
                self.chosenExercises?.remove(at: chosenIndex)
            } else {
                
                self.succesImage.isHidden = false
                self.succesImage.zoomInInfo()
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.succesImage.zoomOutInfo()
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.succesImage.isHidden = true
                    }
                }
                
                self.chosenExercises?.append(selectedExercise.video)
            }
            
            UserDefaults.standard.set(self.chosenExercises, forKey: "chosenExercises")
            tableView.reloadRows(at: [indexPath], with: .automatic)
        })
        
        if isChosen == true {
            chosenAction.image = #imageLiteral(resourceName: "trash")
            chosenAction.backgroundColor = #colorLiteral(red: 0.780459702, green: 0.2858942747, blue: 0.286295712, alpha: 1)
        } else {
            chosenAction.image = #imageLiteral(resourceName: "heartWhite")
            chosenAction.backgroundColor = #colorLiteral(red: 0.1562540944, green: 0.6850157823, blue: 0.6430352619, alpha: 1)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [chosenAction])
        swipeActions.performsFirstActionWithFullSwipe = false
        
        return swipeActions
    }
}

//MARK: - ExtensionIronSource
extension HomeWorkoutTableViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
    //Banner
    func bannerDidLoad(_ bannerView: ISBannerView!) {
        self.bannerView = bannerView
        if #available(iOS 11.0, *) {
               
            if totalSize.height >= 801 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
                
            } else if totalSize.height <= 800 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
            }
        } else {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
        }

        bannerView.backgroundColor = .clear
        bannerView.layer.zPosition = 6
        view.addSubview(bannerView)
        
        logFunctionName()
    }
    func bannerDidShow() {
        logFunctionName()
    }
    func bannerDidFailToLoadWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: Error.self))
    }
    func didClickBanner() {
        logFunctionName()
    }
    func bannerWillPresentScreen() {
        logFunctionName()
    }
    func bannerDidDismissScreen() {
        logFunctionName()
    }
    func bannerWillLeaveApplication() {
        logFunctionName()
    }
    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
        logFunctionName(string: #function+String(describing: impressionData))
    }
}

