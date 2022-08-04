//
//  StretchingTableViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 02.03.2021.
//

import UIKit
import CachingPlayerItem

class StretchingTableViewController: UIViewController {
    
    var choiceMuscle = UserDefaults.standard.integer(forKey: "choiceMuscle")

    let totalSize = UIScreen.main.bounds.size
    
    var chosenExercisesStretching = UserDefaults.standard.array(forKey: "chosenExercisesStretching") as? [String]
    
    var openNextStretchingWorkout = UserDefaults.standard.bool(forKey: "openNextStretchingWorkout")
    var openBackStretchingWorkout = UserDefaults.standard.bool(forKey: "openBackStretchingWorkout")
    var currentIndexStretchingWorkout = UserDefaults.standard.integer(forKey: "currentIndexStretchingWorkout")
    
    @IBOutlet weak var stretchingTableView: UITableView!
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
    //WarmUp
    private let warmUp = [
        Stretching(image: UIImage(named: "warmUp/1")!, imageBackground: UIImage(named: "warmUpImg1")!, text1: "Часть 1".localized(), text2: "ШЕЙНО-ВОРОТНИКОВАЯ ЗОНА".localized(), text3: "Разминка - обязательная мера перед любой тренировкой. Разминка обезопасит Вас от получения травму. \n \n-улучшает пластичность мышц; \n-улучшает кровообращение и насыщает мышцы кислородом; \n-повышает гибкость суставов и сухожилий; \n-значительно снижает риски возникновения травм; \n-увеличивает работоспособность мышечных волокон. \n \nРазминка обязательна для выполнения не зависимо от уровня подготовки.".localized(), text4: "", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FWarm-up%2F1.mp4?alt=media&token=6ff4f4c8-cb1f-4f41-824e-b61c17274c77"),
        Stretching(image: UIImage(named: "warmUp/2")!, imageBackground: UIImage(named: "warmUpImg2")!, text1: "Часть 2".localized(), text2: "ГРУДНОЙ ОТДЕЛ И РУКИ".localized(), text3: "Разминка - обязательная мера перед любой тренировкой. Разминка обезопасит Вас от получения травму. \n \n-улучшает пластичность мышц; \n-улучшает кровообращение и насыщает мышцы кислородом; \n-повышает гибкость суставов и сухожилий; \n-значительно снижает риски возникновения травм; \n-увеличивает работоспособность мышечных волокон. \n \nРазминка обязательна для выполнения не зависимо от уровня подготовки.".localized(), text4: "", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FWarm-up%2F2.mp4?alt=media&token=3321aaf3-bac8-43e0-abfb-de793bbfb846"),
    Stretching(image: UIImage(named: "warmUp/3")!, imageBackground: UIImage(named: "warmUpImg3")!, text1: "Часть 3".localized(), text2: "СПИНА И ТАЗОБЕДРЕННЫЕ СУСТАВЫ".localized(), text3: "Разминка - обязательная мера перед любой тренировкой. Разминка обезопасит Вас от получения травму. \n \n-улучшает пластичность мышц; \n-улучшает кровообращение и насыщает мышцы кислородом; \n-повышает гибкость суставов и сухожилий; \n-значительно снижает риски возникновения травм; \n-увеличивает работоспособность мышечных волокон. \n \nРазминка обязательна для выполнения не зависимо от уровня подготовки.".localized(), text4: "", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FWarm-up%2F3.mp4?alt=media&token=aa541bb8-99ae-4b65-a280-675d9ea11dfd"),
    Stretching(image: UIImage(named: "warmUp/4")!, imageBackground: UIImage(named: "warmUpImg4")!, text1: "Часть 4".localized(), text2: "КОЛЕННЫЕ СУСТАВЫ, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА И ТБС".localized(), text3: "Разминка - обязательная мера перед любой тренировкой. Разминка обезопасит Вас от получения травму. \n \n-улучшает пластичность мышц; \n-улучшает кровообращение и насыщает мышцы кислородом; \n-повышает гибкость суставов и сухожилий; \n-значительно снижает риски возникновения травм; \n-увеличивает работоспособность мышечных волокон. \n \nРазминка обязательна для выполнения не зависимо от уровня подготовки.".localized(), text4: "", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FWarm-up%2F4.mp4?alt=media&token=ad15061e-55d6-4a96-af23-5696462b705f"),
    Stretching(image: UIImage(named: "warmUp/5")!, imageBackground: UIImage(named: "warmUpImg5")!, text1: "Часть 5".localized(), text2: "ГОЛЕНОСТОП, ЗАДНЯЯ ПОВЕРХНОСТЬ БЕДРА И ТБС".localized(), text3: "Разминка - обязательная мера перед любой тренировкой. Разминка обезопасит Вас от получения травму. \n \n-улучшает пластичность мышц; \n-улучшает кровообращение и насыщает мышцы кислородом; \n-повышает гибкость суставов и сухожилий; \n-значительно снижает риски возникновения травм; \n-увеличивает работоспособность мышечных волокон. \n \nРазминка обязательна для выполнения не зависимо от уровня подготовки.".localized(), text4: "", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FWarm-up%2F5.mp4?alt=media&token=81bcc3e9-2f11-4921-97d9-ea2042084264")]
    //FlexibleBack
    private let flexibleBack = [
    Stretching(image: UIImage(named: "flexibleBack/2")!, imageBackground: UIImage(named: "stretchingImg13_5")!, text1: "Разворот корпуса".localized(), text2: "В СКЛАДКЕ НОГИ ВРОЗЬ".localized(), text3: "Примечание: \n \n-В положение сидя максимально разведите ноги, выпрямите колени и затяните носки ног, спина прямая. \n \n-Во время наклона вперёд поверните корпус лицом к ноге, нижнюю руку вытяните к ноге, правую руку вытяните параллельно полу.".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F13_5.mp4?alt=media&token=c5904887-9f61-455c-b100-74607f498eb8"),
    Stretching(image: UIImage(named: "flexibleBack/1")!, imageBackground: UIImage(named: "stretchingImg13_3")!, text1: "Наклоны плечом к полу".localized(), text2: "В СКЛАДКЕ НОГИ ВРОЗЬ".localized(), text3: "Примечание: \n \n-В положение сидя максимально разведите ноги, выпрямите колени и затяните носки ног, спина прямая. \n \n-Во время наклона корпус держите параллельно ноги, наклоняясь в максимальное положение в точку перед коленом, сократите стопу стараясь коснуться её рукой.".localized(), text4: "По 10 наклонов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F13_3.mp4?alt=media&token=c0909164-a5cc-4bfa-8bd0-1896f40220c6"),
    Stretching(image: UIImage(named: "flexibleBack/3")!, imageBackground: UIImage(named: "stretchingImg14_3")!, text1: "Скручивание корпуса".localized(), text2: "В ВЫПАДЕ".localized(), text3: "Примечание: \n \n-Примите положение выпада с колена, затяните носок задней ноги. \n \n-Выпрямите спину, округлив грудной отдел. \n \n-Корпус разверните в сторону передней ноги, зафиксировав переднюю руку на колене, заднюю на икроножных мышцах.".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F14_3.mp4?alt=media&token=25026eb1-3a84-4bf8-b142-dee6875c2c65"),
    Stretching(image: UIImage(named: "flexibleBack/4")!, imageBackground: UIImage(named: "stretchingImg21")!, text1: "Наклоны корпуса".localized(), text2: "В ПОПЕРЕЧНОМ ШПАГАТЕ".localized(), text3: "Примечание: \n \n-Примите положение поперечного шпагата, колени прямые, носки затянутые, спина прямая. \n \n-Наклоните корпус плечом к полу в точку перед коленом, верхней рукой пытайтесь достать до стопы.".localized(), text4: "Фиксация по 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F21.mp4?alt=media&token=29006cf3-e06e-4e71-b412-908c61f7075a"),
    Stretching(image: UIImage(named: "flexibleBack/5")!, imageBackground: UIImage(named: "stretchingImg22")!, text1: "Удлиненная бабочка".localized(), text2: "С ФИКСАЦИЕЙ".localized(), text3: "Примечание: \n \n-В спине допустимо небольшое округление, грудным отделом тянитесь к стопе. \n \n-Руки зафиксируйте на стопах, в положении максимума динамически покачивайтесь корпусом.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F22.mp4?alt=media&token=00bc47ba-32ba-4161-985b-79a2f397b577"),
    Stretching(image: UIImage(named: "flexibleBack/6")!, imageBackground: UIImage(named: "stretchingImg23_1")!, text1: "Прогиб и округление спины ".localized(), text2: "В УПОРЕ".localized(), text3: "Примечание: \n \n-Упор на колени и прямые руки. \n \n-На вдох максимально прогибайтесь в спине, на выдох максимально округлите спину.".localized(), text4: "10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F23_1.mp4?alt=media&token=1b8cf91c-4f6d-424c-8d87-78814c415e85"),
    Stretching(image: UIImage(named: "flexibleBack/7")!, imageBackground: UIImage(named: "stretchingImg23_2")!, text1: "Вращение корпуса".localized(), text2: "В УПОРЕ  ".localized(), text3: "Примечание: \n \n-Упор на колени и прямые руки. \n \n-Плавно вращайте корпусом, в положении максимального прогиба делайте вдох, в положении максимального округления делайте выдох.".localized(), text4: "По 8 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F23_2.mp4?alt=media&token=64df1523-177d-4f55-b9a4-d6b89e5e752c"),
    Stretching(image: UIImage(named: "flexibleBack/8")!, imageBackground: UIImage(named: "stretchingImg23_3")!, text1: "Прогиб спины".localized(), text2: "В ПОЗЕ КОШКИ".localized(), text3: "Примечание: \n \n-Упор на колени, руки вытяните вперёд, на выдохе спину уводим в прогиб к полу, таз при этом не уводим в сторону.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F23_3.mp4?alt=media&token=5b95b118-1960-473a-a48c-844f68a30d79"),
    Stretching(image: UIImage(named: "flexibleBack/9")!, imageBackground: UIImage(named: "stretchingImg23_4")!, text1: "Прогиб и округление спины".localized(), text2: "НА ВЫТЯНУТЫХ РУКАХ".localized(), text3: "Примечание: \n \n-Упор на колени, руки подайте вперёд. \n \n-На вдох максимально прогибайтесь в спине, подавая таз немного вперёд, на выдох максимально округлите спину, не заваливая таз назад.".localized(), text4: "10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F23_4.mp4?alt=media&token=3f9d4996-b4ec-4889-a798-ff9d05f477e7"),
    Stretching(image: UIImage(named: "flexibleBack/10")!, imageBackground: UIImage(named: "stretchingImg23_5")!, text1: "Собака мордой вниз".localized(), text2: "ИЗ УПОРА".localized(), text3: "Примечание: \n \n-Из упора на коленях, отведите таз назад не отрывая рук, выйдите на прямые ноги, на выдохе максимально прогнитесь в спине, грудным отделом тянитесь к полу.".localized(), text4: "10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F23_5.mp4?alt=media&token=f42593ee-49f3-445d-923d-349fda4286bc"),
    Stretching(image: UIImage(named: "flexibleBack/11")!, imageBackground: UIImage(named: "stretchingImg23_6")!, text1: "Скорпион".localized(), text2: "В УПОРЕ".localized(), text3: "Примечание: \n \n-Держите колени и спину прямыми, руки также не сгибайте в локтях. \n \n-Поднимайте ногу максимально вверх и в положении максимума согните ногу в колене, стопой тянитесь к голове.".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F23_6.mp4?alt=media&token=a9bab013-9b4c-4760-afe8-4d96b80ea3ba"),
    Stretching(image: UIImage(named: "flexibleBack/12")!, imageBackground: UIImage(named: "stretchingImg24")!, text1: "Поза ребёнка - прогиб ".localized(), text2: "ЧЕРЕДОВАНИЕ".localized(), text3: "Примечание: \n \n-В положении максимального прогиба упор на прямые руки и носки ног, колени при этом выпрямлены, головой тянитесь назад, увеличивая прогиб. \n \n-В позе ребёнка упор на колени и прямые руки, допускается прогиб в пояснице.".localized(), text4: "10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F24.mp4?alt=media&token=75da0851-c14d-4080-9871-0bd8e728ed6b"),
    Stretching(image: UIImage(named: "flexibleBack/13")!, imageBackground: UIImage(named: "stretchingImg25")!, text1: "Берёзка".localized(), text2: "НОГИ ЗА ГОЛОВОЙ".localized(), text3: "Примечание: \n \n1 - В постановку за голову, округлите спину, закиньте прямые в коленях ноги, уводя стопу как можно дальше от головы, фиксация 10-20 секунд. \n \n2 - Переводим руки к стопе, фиксация 10-20 секунд. \n \n3 - сократите стопу, подведите колени к груди, фиксация 10-20 секунд. \n \n4 - переход на 'берёзку' с прогибом в пояснице, упор на локти, фиксация 10-20 секунд.".localized(), text4: "Фиксация по 10-20 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F25.mp4?alt=media&token=ab6b7e58-7b0e-4a3a-84fc-054c258b0a45"),
    Stretching(image: UIImage(named: "flexibleBack/14")!, imageBackground: UIImage(named: "stretchingImg26")!, text1: "Боковые скручивания".localized(), text2: "ЛЁЖА НА СПИНЕ".localized(), text3: "Примечание: \n \n-Ноги располагайте под прямым углом, носки затянуты. \n \n-Во время выполнения отведите лицо и таз в противоположную сторону, расставьте руки в стороны для лучшее фиксации.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FFlexibleBack%2F26.mp4?alt=media&token=48ec8d8f-5395-408e-b0d3-59905d9eb23c")]
    //SideSplits
    private let sideSplits = [
    Stretching(image: UIImage(named: "sideSplits/1")!, imageBackground: UIImage(named: "stretchingImg1")!, text1: "Наклоны вперёд".localized(), text2: "СТОЯ".localized(), text3: "Примечание: \n \n-Расставьте ноги на ширине плеч, во время выполнения упражнения старайтесь держать колени и спину прямыми, таз открытым. Распределите вес на переднюю часть стопы. Грудным отделом тянитесь к стопе. \n \n-На выдохе медленно наклоняйтесь вперёд в вертикальную складку до положения максимума, с последующей фиксацией в положении максимума 3-5 секунд.".localized(), text4: "10 наклонов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F1.mp4?alt=media&token=95309dc7-6268-4905-bbc1-40217036da03"),
    Stretching(image: UIImage(named: "sideSplits/2")!, imageBackground: UIImage(named: "stretchingImg5_1")!, text1: "Продольный выпад".localized(), text2: "С ФИКСАЦИЕЙ".localized(), text3: "Примечание: \n \n-Таз тянется вниз, бёдра расслабленны, колено задней ноги прямое, центр тяжести корпуса на переднем бедре, руки прямые, зафиксированы в упор на кубики, спина прямая.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F5_1.mp4?alt=media&token=5af75f66-934d-4ecc-9769-eb55b2786c64"),
    Stretching(image: UIImage(named: "sideSplits/3")!, imageBackground: UIImage(named: "stretchingImg5_2")!, text1: "Продольный выпад".localized(), text2: "С ПОКАЧИВАНИЯМИ".localized(), text3: "Примечание: \n \n-Таз в динамике тянется вниз, бёдра расслабленны, колено задней ноги прямое, центр тяжести корпуса на переднем бедре, руки прямые, зафиксированы в упор на кубики, спина прямая.".localized(), text4: "10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F5_2.mp4?alt=media&token=da99e18f-89dd-432f-a830-f790a666aef4"),
    Stretching(image: UIImage(named: "sideSplits/4")!, imageBackground: UIImage(named: "stretchingImg5_3")!, text1: "Фиксация в выпаде".localized(), text2: "С РУКАМИ ВВЕРХ".localized(), text3: "Примечание: \n \n-Таз тянется вниз, бёдра расслабленны, колено задней ноги прямое, корпус располагаем в вертикальной плоскости, руки прямые, спина прямая.".localized(), text4: "Фиксация 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F5_3.mp4?alt=media&token=ab4820fb-c0bd-475d-acd2-d30322e4c5f8"),
    Stretching(image: UIImage(named: "sideSplits/5")!, imageBackground: UIImage(named: "stretchingImg5_4")!, text1: "Фиксация в выпаде ".localized(), text2: "ПРЕДПЛЕЧЬЯМИ В УПОРЕ".localized(), text3: "Примечание: \n \n-Таз тянется вниз, бёдра расслабленны, колено задней ноги стоит на полу, центр тяжести корпуса наклоняем вперёд, оба предплечья на полу, спина прямая. \n \n-Старайтесь избежать ухода стопы в завал на внешнюю сторону".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F5_4.mp4?alt=media&token=331a8e5a-4b0c-452c-8c16-5f7714a47a58"),
    Stretching(image: UIImage(named: "sideSplits/6")!, imageBackground: UIImage(named: "stretchingImg6_1")!, text1: "Махи ногами ".localized(), text2: "ЛЁЖА НА СПИНЕ".localized(), text3: "Примечание: \n \n-Займите положение лежа на спине, носки ног затянутые, колени старайтесь держать прямыми, рабочую ногу доводите до максимума к корпусу.".localized(), text4: "По 12 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F6_1.mp4?alt=media&token=a88565fd-ee66-4deb-9e7c-b716294d44fd"),
    Stretching(image: UIImage(named: "sideSplits/7")!, imageBackground: UIImage(named: "stretchingImg6_2")!, text1: "Фиксация ноги в махе".localized(), text2: "ЛЁЖА НА СПИНЕ".localized(), text3: "Примечание: \n \n-Займите положение лежа на спине, носки ног затянутые, колени старайтесь держать прямыми, рабочую ногу доводите до максимума к корпусу, ловите ногу и доводите её до максимума, после чего вы можете дотянуть стопу рабочей ноги на сокращение и притянуть ногу еще ближе к корпусу. \n \n-В завершении отпустите ногу и удерживайте её мышцами в максимуме, у корпуса, без помощи рук, по истечении 10 секунд медленно опускайте ногу.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F6_2.mp4?alt=media&token=31d147e8-dccc-4d3d-b7c4-7b9784b08394"),
    Stretching(image: UIImage(named: "sideSplits/8")!, imageBackground: UIImage(named: "stretchingImg9")!, text1: "Складка ногой вверх".localized(), text2: "С ФИКСАЦИЕЙ".localized(), text3: "Примечание: \n \n-В положении сидя затяните носки ног, старайтесь держать колени прямыми, спина прямая. \n \nЧасть 1 -  Протягивайте ногу в вертикальное положение максимально к корпусу. По возможности сокращайте стопу для проработки на выворотность. \n \nЧасть 2 - Уводите голень в горизонтальную плоскость, протягивайте бедро согнутой ноги, уводя стопу к противоположному плечу.".localized(), text4: "По 1 повторению".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F9.mp4?alt=media&token=ff481d0b-015f-4154-925f-fa3629bd63a0"),
    Stretching(image: UIImage(named: "sideSplits/9")!, imageBackground: UIImage(named: "stretchingImg10")!, text1: "Уголок".localized(), text2: "В ВЕРТИКАЛЬНУЮ СКЛАДКУ".localized(), text3: "Примечание: \n \n-Примите положение сидя, выпрямите спину и затяните носки. \n \n-Во положении фиксации старайтесь держать колени и спину прямыми, подтягивайте ноги максимально к корпусу, держите равновесие. \n \nФиксацией по 10 секунд".localized(), text4: "5 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F10.mp4?alt=media&token=934d42e6-f84a-4f15-8778-6f4b15ebf0c4"),
    Stretching(image: UIImage(named: "sideSplits/10")!, imageBackground: UIImage(named: "stretchingImg11")!, text1: "Наклоны сидя".localized(), text2: "В СКЛАДКУ К НОГЕ".localized(), text3: "Примечание: \n \n-Одну из ног согните в колене, другую ногу выпрямите и затяните носок, поясница прямая. \n \n-После 10 наклонов зафиксируйте корпус у ноги в максимуме в течении 10 секунд, затяните стопу и находитесь в положении максимума еще 20 секунд.".localized(), text4: "По 10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F11.mp4?alt=media&token=742a9632-1de9-4327-b418-106f03abc934"),
    Stretching(image: UIImage(named: "sideSplits/11")!, imageBackground: UIImage(named: "stretchingImg12")!, text1: "Наклоны сидя".localized(), text2: "В СКЛАДКУ К НОГАМ".localized(), text3: "Примечание: \n \n-В положении сидя выпрямите спину и колени, затяните носки ног. \n \n-После 10 наклонов зафиксируйте корпус у ног в максимуме в течении 10 секунд, затяните стопы и находитесь в положении максимума еще 20 секунд.".localized(), text4: "10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F12.mp4?alt=media&token=51df3e48-2718-46c7-b00b-f091939d495d"),
    Stretching(image: UIImage(named: "sideSplits/12")!, imageBackground: UIImage(named: "stretchingImg14_1")!, text1: "Выпад с кубиками".localized(), text2: "С ФИКСАЦИЕЙ ".localized(), text3: "Примечание: \n \n-Примите положение выпада с колена, затяните носок задней ноги. \n \n-Выпрямите спину, округлив грудной отдел, руки зафиксируйте на кубиках.".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F14_1.mp4?alt=media&token=0e4abb9b-145b-4978-bb3e-a76d0261a0ef"),
    Stretching(image: UIImage(named: "sideSplits/13")!, imageBackground: UIImage(named: "stretchingImg14_2")!, text1: "Фиксация в выпаде".localized(), text2: "С РУКАМИ ВВЕРХ".localized(), text3: "Примечание: \n \n-Примите положение выпада с колена, затяните носок задней ноги. \n \n-Выпрямите спину, округлив грудной отдел, руки вытяните вверх. \n \n-Раскачивайте таз вниз до максимального положения и вверх, плавно.".localized(), text4: "10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F14_2.mp4?alt=media&token=ad31aa72-5745-4738-bffb-7580984bfc0e"),
    Stretching(image: UIImage(named: "sideSplits/14")!, imageBackground: UIImage(named: "stretchingImg14_3")!, text1: "Скручивание корпуса ".localized(), text2: "В ВЫПАДЕ".localized(), text3: "Примечание: \n \n-Примите положение выпада с колена, затяните носок задней ноги. \n \n-Выпрямите спину, округлив грудной отдел. \n \n-Корпус разверните в сторону передней ноги, зафиксировав переднюю руку на колене, заднюю на икроножных мышцах.".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F14_3.mp4?alt=media&token=95529975-7da6-4df9-a45c-f1e6c2e1c1d5"),
    Stretching(image: UIImage(named: "sideSplits/15")!, imageBackground: UIImage(named: "stretchingImg14_4")!, text1: "Фиксация задней ноги".localized(), text2: "В ВЫПАДЕ".localized(), text3: "Примечание: \n \n-Примите положение выпада с колена, затяните носок задней ноги. \n \n-Выпрямите спину, округлив грудной отдел. \n \n-Корпус разверните в сторону задней ноги, согнув заднюю ногу, подтяните её к ягодице, держа её за стопу.".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F14_4.mp4?alt=media&token=1c88835b-1ba1-41dd-beb4-7cc3357a4779"),
    Stretching(image: UIImage(named: "sideSplits/16")!, imageBackground: UIImage(named: "stretchingImg14_5")!, text1: "Протягивание корпуса".localized(), text2: "С ФИКСАЦИЕЙ".localized(), text3: "Примечание: \n \n-Из положения выпада выпрямите переднюю ногу ,отодвинув таз назад. \n \n-Корпус наклоните максимально вперёд к ноге, сократив переднюю стопу, расположив руки на опоре. \n \n-После сократите стопу, задействовала ноги.".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F14_5.mp4?alt=media&token=7b0ea5f6-a43b-45e4-a490-1fbe2580fc58"),
    Stretching(image: UIImage(named: "sideSplits/17")!, imageBackground: UIImage(named: "stretchingImg15_1")!, text1: "Продольный шпагат".localized(), text2: "С ФИКСАЦИЕЙ".localized(), text3: "Примечание: \n \n-Примите положение продольного шпагата / максимально возможное положение, по необходимости опираясь на руки. \n \n-Во время выполнения держите колени прямыми, носки ног затяните, спина прямая, грудная клетка округлена. \n \n-Плавно отклоняйте корпус назад.".localized(), text4: "Фиксация по 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F15_1.mp4?alt=media&token=ab2f009a-8d99-49d2-985b-88ab306e74c5"),
    Stretching(image: UIImage(named: "sideSplits/18")!, imageBackground: UIImage(named: "stretchingImg15_2")!, text1: "Наклон с фиксацией".localized(), text2: "В ПРОДОЛЬНОМ ШПАГАТЕ".localized(), text3: "Примечание: \n \n-Примите положение продольного шпагата / максимально возможное положение, по необходимости опираясь на руки. \n \n-Выпрямите колени, носки ног затяните, спина прямая. \n \n-Плавно наклоните корпус в максимальное положение в передней ноге.".localized(), text4: "Фиксация по 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F15_2.mp4?alt=media&token=815acf3b-6b05-484a-aa3b-8add7f636d69"),
    Stretching(image: UIImage(named: "sideSplits/19")!, imageBackground: UIImage(named: "stretchingImg15_3")!, text1: "Нога в кольцо".localized(), text2: "В ПРОДОЛЬНОМ ШПАГАТЕ".localized(), text3: "Примечание: \n \n-Примите положение продольного шпагата. \n \n-Во время выполнения держите колени прямыми, носки ног затяните, спина прямая, грудная клетка округлена. \n \n-Согните заднюю ногу в колене, повернув корпус зафиксируйте ногу, держа её за стопу, после смены руки, разверните корпус обратно и образуйте кольцо.".localized(), text4: "Фиксация по 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F15_3.mp4?alt=media&token=c39cfd6e-2eb3-4d17-b5cf-1f756658421f"),
    Stretching(image: UIImage(named: "sideSplits/20")!, imageBackground: UIImage(named: "stretchingImg23_6")!, text1: "Скорпион".localized(), text2: "В УПОРЕ".localized(), text3: "Примечание: \n \n-Держите колени и спину прямыми, руки также не сгибайте в локтях. \n \n-Поднимайте ногу максимально вверх и в положении максимума согните ногу в колене, стопой тянитесь к голове.".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FSideSplits%2F23_6.mp4?alt=media&token=820731d7-5122-468f-90fd-4ef0592c5f91")]
    //LongTwine
    private let longTwine = [
    Stretching(image: UIImage(named: "longTwine/1")!, imageBackground: UIImage(named: "stretchingImg2")!, text1: "Боковые выпады".localized(), text2: "ПООЧЕРЁДНО".localized(), text3: "Примечание: \n \n-Расставьте ноги чуть шире плеч, развернув стопы в диагональ. \n \n-Расположите руки на опоре чуть выше пола, в случае отсутствия инвентаря, это может быть любой устойчивый предмет. \n \n-Спина прямая, чувствуйте поочередное подключение на растягивание внутренней поверхности бёдра. \n \n-В выпаде колено направленно в сторону стопы, уходя чуть дальше стопы. ".localized(), text4: "20 выпадов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F2.mp4?alt=media&token=f26244e8-e9fa-4408-8811-9a2c3e3741bd"),
    Stretching(image: UIImage(named: "longTwine/2")!, imageBackground: UIImage(named: "stretchingImg3")!, text1: "Гран-плие".localized(), text2: "С ШИРОКОЙ ПОСТАНОВКОЙ НОГ".localized(), text3: "Примечание: \n \n-Расставьте ноги чуть шире плеч, развернув стопы в стороны. \n \n-Точка опоры на пятки. \n \n-Таз подкручен и стремится уйти ниже линии горизонта, пальцами рук тянемся к полу, спина при этом прямая, старайтесь чтобы корпус не заваливался вперёд.".localized(), text4: "12 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F3.mp4?alt=media&token=b3f0960c-bee8-4fa9-af32-902e331cd7d4"),
    Stretching(image: UIImage(named: "longTwine/3")!, imageBackground: UIImage(named: "stretchingImg4")!, text1: "Гранд-плие".localized(), text2: "С ФИКСАЦИЕЙ  ".localized(), text3: "Примечание: \n \n-Фиксация в горизонтальной плоскости в Гранд-плие через предплечье в упор на бёдра. \n \n-Расставьте ноги чуть шире плеч, развернув стопы в стороны. \n \n-Точка опоры на пятки. \n \n-Таз подкручен и стремится уйти ниже линии горизонта, спина при этом прямая, подаем корпус немного вперёд для удобства фиксации, ягодичные и бёдра расслаблены, плечевой пояс зафиксирован, локти работают в упор на бёдра, раскрывая их по сторонам.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F4.mp4?alt=media&token=2313d023-964f-405b-9d62-232422d81a47"),
    Stretching(image: UIImage(named: "longTwine/4")!, imageBackground: UIImage(named: "stretchingImg7_1")!, text1: "Махи ногами".localized(), text2: "ЛЕЖА НА БОКУ".localized(), text3: "Примечание: \n \n-Займите положение лежа на боку, вытяните руку, корпус, ноги и стопы в одну линию. \n \n-Колени держите прямыми, таз подайте вперёд, рабочую ногу старайтесь уводить за плечо, доводя ногу в максимум к корпусу.".localized(), text4: "12 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F7_1.mp4?alt=media&token=6ccf3248-c8e8-49bc-87da-93dc64c25658"),
    Stretching(image: UIImage(named: "longTwine/5")!, imageBackground: UIImage(named: "stretchingImg7_2")!, text1: "Фиксация ноги в махе".localized(), text2: "ЛЁЖА НА БОКУ".localized(), text3: "Примечание: \n \n-Займите положение лежа на боку, вытяните руку, корпус, ноги и стопы в одну линию. \n \n-Колени держите прямыми, таз подайте вперёд, рабочую ногу старайтесь уводить за плечо, доводя ногу в максимум к корпусу поймайте её рукой и доведите до максимума, колено нижней ноги согните.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F7_2.mp4?alt=media&token=7de2b69d-4702-4b6f-86a6-c04adda803ac"),
    Stretching(image: UIImage(named: "longTwine/6")!, imageBackground: UIImage(named: "stretchingImg7_3")!, text1: "Фиксация ноги в махе".localized(), text2: "С СОКРАЩЕННОЙ СТОПОЙ ".localized(), text3: "Примечание: \n \n-Займите положение лежа на боку, вытяните руку, корпус, ноги и стопы в одну линию. \n \n-Колени держите прямыми, таз подайте вперёд, рабочую ногу старайтесь уводить за плечо, доводя ногу в максимум к корпусу поймайте её рукой и доведите до максимума, колено нижней ноги согните. \n \n-После доверните стопу ноги на сокращение.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F7_3.mp4?alt=media&token=600e128d-986f-43ea-85d4-7a798e3dcbe8"),
    Stretching(image: UIImage(named: "longTwine/7")!, imageBackground: UIImage(named: "stretchingImg8")!, text1: "Вращение ногами".localized(), text2: "ЛЁЖА".localized(), text3: "Примечание: \n \n-Ввиду ваших физических возможностей вращайте ногой с согнутым или прямым коленом. \n \n-Старайтесь работать по максимальной амплитуде. \n \n-Корпус зафиксируйте неподвижно. \n \n-В случае выполнения с прямым коленом, колено во время вращения не сгибается.".localized(), text4: "По 5 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F8.mp4?alt=media&token=0fb68955-5fd4-4b41-84d6-6877afbd1cf3"),
    Stretching(image: UIImage(named: "longTwine/8")!, imageBackground: UIImage(named: "stretchingImg13_1")!, text1: "Наклоны лицом к ноге".localized(), text2: "В СКЛАДКЕ НОГИ ВРОЗЬ".localized(), text3: "Примечание: \n \n-В положение сидя максимально разведите ноги, выпрямите колени и затяните носки ног, спина прямая. \n \n-Во время наклона корпус поверните лицом к ноге, наклоняясь в максимальное положение к ноге. ".localized(), text4: "По 10 наклонов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F13_1.mp4?alt=media&token=3943aba6-85e2-4359-904a-f39c5f812e72"),
    Stretching(image: UIImage(named: "longTwine/9")!, imageBackground: UIImage(named: "stretchingImg13_2")!, text1: "Наклоны с фиксацией стопы".localized(), text2: "В СКЛАДКЕ НОГИ ВРОЗЬ ".localized(), text3: "Примечание: \n \n-В положение сидя максимально разведите ноги, выпрямите колени и затяните носки ног, спина прямая. \n \n-Во время наклона корпус поверните лицом к ноге, наклоняясь в максимальное положение к ноге, возьмите стопу руками и максимально подверните стопу к себе. \n \nФиксация по 5 секунд.".localized(), text4: "По 6 наклонов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F13_2.mp4?alt=media&token=8a559abf-0886-4f21-8ac9-eae8d33c698b"),
    Stretching(image: UIImage(named: "longTwine/10")!, imageBackground: UIImage(named: "stretchingImg13_3")!, text1: "Наклоны плечом к полу".localized(), text2: "В СКЛАДКЕ НОГИ ВРОЗЬ".localized(), text3: "Примечание: \n \n-В положение сидя максимально разведите ноги, выпрямите колени и затяните носки ног, спина прямая. \n \n-Во время наклона корпус держите параллельно ноги, наклоняясь в максимальное положение в точку перед коленом, сократите стопу стараясь коснуться её рукой.".localized(), text4: "По 10 наклонов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F13_3.mp4?alt=media&token=4f5eee9f-2ad4-4085-a44e-a8774b4d8f27"),
    Stretching(image: UIImage(named: "longTwine/11")!, imageBackground: UIImage(named: "stretchingImg13_4")!, text1: "Наклон вперёд".localized(), text2: "В СКЛАДКЕ НОГИ ВРОЗЬ".localized(), text3: "Примечание: \n \n-В положение сидя максимально разведите ноги, выпрямите колени и затяните носки ног, спина прямая. \n \n-Во время наклона тянитесь руками максимально вперёд, не сгибая спину. В положении максимума зафиксируйтесь.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F13_4.mp4?alt=media&token=7b10bd90-f081-4968-97f9-0aa7b6a5aaf7"),
    Stretching(image: UIImage(named: "longTwine/12")!, imageBackground: UIImage(named: "stretchingImg13_5")!, text1: "Разворот корпуса".localized(), text2: "В СКЛАДКЕ НОГИ ВРОЗЬ".localized(), text3: "Примечание: \n \n-В положение сидя максимально разведите ноги, выпрямите колени и затяните носки ног, спина прямая. \n \n-Во время наклона вперёд поверните корпус лицом к ноге, нижнюю руку вытяните к ноге, правую руку вытяните параллельно полу. ".localized(), text4: "Фиксация по 10 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F13_5.mp4?alt=media&token=402ed6eb-e54d-4ad3-9095-06349bbeb692"),
    Stretching(image: UIImage(named: "longTwine/13")!, imageBackground: UIImage(named: "stretchingImg16")!, text1: "Вертикальная лягушка".localized(), text2: "НА КОЛЕНЯХ".localized(), text3: "Примечание: \n \n-Широко разведите колени, стопы направьте друг к другу. \n \n-Руки фиксируйте на стопах, прогнитесь в пояснице, раскройте грудной отдел.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F16.mp4?alt=media&token=7c79d9a5-0ea5-48aa-9a7a-6fa58266c714"),
    Stretching(image: UIImage(named: "longTwine/14")!, imageBackground: UIImage(named: "stretchingImg17")!, text1: "Ноги буквой ‘П’".localized(), text2: "В УПОРЕ".localized(), text3: "Примечание: \n \n-Расставьте колени максимально широко, 90 градусов в коленях, фиксация в первом положении на прямых руках 30 секунд. \n \n-Поясница прогнута, грудная клетка раскрыта, таз  открыт и находится на одной линии с коленом, плечи не уходят ниже линии бедра. \n \n-После фиксации наклоните корпус в упор на предплечья, с фиксацией в этом положении еще на 30 секунд с динамическими покачиваниями назад из исходного положения.".localized(), text4: "2 фиксации по 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F17.mp4?alt=media&token=6459c014-9708-46b3-bad0-1e3a60201d62"),
    Stretching(image: UIImage(named: "longTwine/15")!, imageBackground: UIImage(named: "stretchingImg18_1")!, text1: "Ноги буквой ‘П’".localized(), text2: "С ФИКСАЦИЕЙ   ".localized(), text3: "Примечание: \n \n-Одну из ног согните в колене 90 градусов, другую ногу выпрямите в колене, затяните носок, поясница прогнута, грудная клетка раскрыта. \n \n-Зафиксируйтесь на прямых руках, плечи не должны выходить на линию ног.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F18_1.mp4?alt=media&token=702f5864-3131-4000-8e74-ba274c3ffeac"),
    Stretching(image: UIImage(named: "longTwine/16")!, imageBackground: UIImage(named: "stretchingImg18_2")!, text1: "Ноги буквой ‘П’".localized(), text2: "В УПОРЕ НА ПРЕДПЛЕЧЬЯ".localized(), text3: "Примечание: \n \n-Одну из ног согните в колене 90 градусов, другую ногу выпрямите в колене, затяните носок, поясница прогнута, грудная клетка раскрыта. \n \n-Наклоните корпус в упор на предплечья.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F18_2.mp4?alt=media&token=f24fdf90-4c1c-4e85-842c-0cb7b4732087"),
    Stretching(image: UIImage(named: "longTwine/17")!, imageBackground: UIImage(named: "stretchingImg18_3")!, text1: "Ноги буквой ‘П’".localized(), text2: "В НАКЛОНЕ".localized(), text3: "Примечание: \n \n-Одну из ног согните в колене 90 градусов, другую ногу выпрямите в колене, затяните носок, поясница прогнута, грудная клетка раскрыта. \n \n-Наклоните корпус к ноге плечом в точку перед коленом, не поворачивая его.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F18_3.mp4?alt=media&token=f7d6713a-98e3-4b1b-bec1-5e8e830f1097"),
    Stretching(image: UIImage(named: "longTwine/18")!, imageBackground: UIImage(named: "stretchingImg19_1")!, text1: "Разножка".localized(), text2: "НА ПОПЕРЕЧНЫЙ ШПАГАТ " .localized(), text3: "Примечание: \n \n-Лежа на спине вытяните ноги вверх, колени прямые, носки затянутые. \n \n-Динамически отводите ноги, в максимуме необходимо расслабить пах, чтобы ноги аккуратно пружинили на связке.".localized(), text4: "10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F19_1.mp4?alt=media&token=e14c7fe3-799c-45e7-b78a-118386efd524"),
    Stretching(image: UIImage(named: "longTwine/19")!, imageBackground: UIImage(named: "stretchingImg19_2")!, text1: "Фиксация в разножке".localized(), text2: "НА ПОПЕРЕЧНЫЙ ШПАГАТ".localized(), text3: "Примечание: \n \n-Лежа на спине вытяните ноги вверх, колени прямые, носки затянутые. \n \n-Отводите ноги, в максимуме необходимо поймать ноги руками и зафиксировать их в течении 15 секунд, далее сократите стопы, взявшись за них руками и доведите ноги до максимального положения, зафиксировавшись еще на 15 секунд. ".localized(), text4: "2 фиксации по 15 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F19_2.mp4?alt=media&token=392f84d2-96c7-4b5a-8c99-90ed461be6f2"),
    Stretching(image: UIImage(named: "longTwine/20")!, imageBackground: UIImage(named: "stretchingImg20")!, text1: "Переходы".localized(), text2: "ЧЕРЕЗ ПОПЕРЕЧНЫЙ ШПАГАТ".localized(), text3: "Примечание: \n \n-Во время выполнения упражнения держите колени прямыми, носки затянутыми. \n \n-Прогните поясницу, раскройте грудную клетку. \n \n-Разводите ноги максимально широко, прокатывайтесь с помощью рук.".localized(), text4: "8 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F20.mp4?alt=media&token=936c00ec-5051-4548-bb1e-5817369fbef6"),
    Stretching(image: UIImage(named: "longTwine/21")!, imageBackground: UIImage(named: "stretchingImg21")!, text1: "Наклоны корпуса".localized(), text2: "В ПОПЕРЕЧНОМ ШПАГАТЕ".localized(), text3: "Примечание: \n \n-Примите положение поперечного шпагата, колени прямые, носки затянутые, спина прямая. \n \n-Наклоните корпус плечом к полу в точку перед коленом, верхней рукой пытайтесь достать до стопы.".localized(), text4: "Фиксация по 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F21.mp4?alt=media&token=44a208fb-8ba1-4dff-9029-b35e128db347"),
    Stretching(image: UIImage(named: "longTwine/22")!, imageBackground: UIImage(named: "stretchingImg22")!, text1: "Удлиненная бабочка".localized(), text2: "С ФИКСАЦИЕЙ".localized(), text3: "Примечание: \n \n-В спине допустимо небольшое округление, грудным отделом тянитесь к стопе. \n \n-Руки зафиксируйте на стопах, в положении максимума динамически покачивайтесь корпусом.".localized(), text4: "Фиксация 30 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Stretching%2FLongTwine%2F22.mp4?alt=media&token=2e8d0db4-4689-4fec-b516-cb9416cb3c67")]
    
    private var selectedTransform: Stretching?

//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        backgroundImage.isHidden = false
        
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
        stretchingTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positY)
        }
        stretchingTableView.layer.zPosition = 5
        
        let customFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        customFooterView.backgroundColor = .clear

        self.stretchingTableView.tableFooterView = customFooterView
        
        setNavBarToTheView()
        
        navigationController?.isNavigationBarHidden = true
            
        dismissButton.addTarget(self, action: #selector(buttonDismiss), for: .touchUpInside)
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            if self.openNextStretchingWorkout == true {
            UserDefaults.standard.set(false, forKey: "openNextStretchingWorkout")
            self.nextWorkout()
            }
            if self.openBackStretchingWorkout == true {
            UserDefaults.standard.set(false, forKey: "openBackStretchingWorkout")
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
//MARK: - ImageBackgroundTransition
    lazy var imageBackgroundTransition: UIImageView = {
        var img = UIImageView()
        if totalSize.height >= 920 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionStretching12ProMax"))
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionStretching"))
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionStretching12"))
        } else if totalSize.height == 812 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionStretching12Mini"))
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionStretching7+"))
        } else if totalSize.height <= 670 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionStretchingMin"))
        } else {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionStretching12Mini"))
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
        let indexPath = IndexPath(item: currentIndexStretchingWorkout + 1, section: 0)
        
        var countList = IndexPath()
        
        if choiceMuscle == 1 {
            countList = IndexPath(item: warmUp.count - 1, section: 0)
        } else if choiceMuscle == 2 {
            countList = IndexPath(item: flexibleBack.count - 1, section: 0)
        } else if choiceMuscle == 3 {
            countList = IndexPath(item: sideSplits.count - 1, section: 0)
        } else if choiceMuscle == 4 {
            countList = IndexPath(item: longTwine.count - 1, section: 0)
        }
        
        let countListBack = IndexPath(item: 2, section: 0)
        
        if indexPath <= countList {
            if openNextStretchingWorkout == true {
                imageBackgroundTransition.isHidden = false
            }
        }
        if indexPath >= countListBack {
            if openBackStretchingWorkout == true {
                imageBackgroundTransition.isHidden = false
            }
        }
    }
//MARK: - NextWorkout
     func nextWorkout() {
        let indexPath = IndexPath(item: currentIndexStretchingWorkout + 1, section: 0)
        
        var countList = IndexPath()
        
        if choiceMuscle == 1 {
            countList = IndexPath(item: warmUp.count - 1, section: 0)
        } else if choiceMuscle == 2 {
            countList = IndexPath(item: flexibleBack.count - 1, section: 0)
        } else if choiceMuscle == 3 {
            countList = IndexPath(item: sideSplits.count - 1, section: 0)
        } else if choiceMuscle == 4 {
            countList = IndexPath(item: longTwine.count - 1, section: 0)
        }
        
        if indexPath <= countList {
        
        destroyBanner()
            
        UserDefaults.standard.set(indexPath.row, forKey: "currentIndexStretchingWorkout")

        if choiceMuscle == 1 {
            selectedTransform = warmUp[indexPath.row]
        } else if choiceMuscle == 2 {
            selectedTransform = flexibleBack[indexPath.row]
        } else if choiceMuscle == 3 {
            selectedTransform = sideSplits[indexPath.row]
        } else if choiceMuscle == 4 {
            selectedTransform = longTwine[indexPath.row]
        }

        performSegue(withIdentifier: "stretchingSegue", sender: nil)
        }
    }
//MARK: - BackWorkout
     func backWorkout() {
        let indexPath = IndexPath(item: currentIndexStretchingWorkout - 1, section: 0)
        
        let countList = IndexPath(item: 0, section: 0)
        
        if indexPath >= countList {
        
        destroyBanner()
            
        UserDefaults.standard.set(indexPath.row, forKey: "currentIndexStretchingWorkout")

        if choiceMuscle == 1 {
            selectedTransform = warmUp[indexPath.row]
        } else if choiceMuscle == 2 {
            selectedTransform = flexibleBack[indexPath.row]
        } else if choiceMuscle == 3 {
            selectedTransform = sideSplits[indexPath.row]
        } else if choiceMuscle == 4 {
            selectedTransform = longTwine[indexPath.row]
        }

        performSegue(withIdentifier: "stretchingSegue", sender: nil)
        }
    }
//MARK: - SuccessImage
    lazy var succesImage: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "checkedPink"))
        img.contentMode = .scaleAspectFit
        img.layer.zPosition = 6
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
            navItem.title = "Разминка".localized()
        case 2:
            navItem.title = "Гибкая спина".localized()
        case 3:
            navItem.title = "Продольный шпагат".localized()
        case 4:
            navItem.title = "Поперечный шпагат".localized()
        default:
            navItem.title = ""
        }
        
        
        navBar.setItems([navItem], animated: true)
    }
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "backgroundStretchingMenu"))
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 0
        image.alpha = 0.3
        self.view.addSubview(image)


        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(0)
    }
        return image
    }()
//MARK: Dismiss
    @objc lazy var dismissButton: UIButton = {
        
        let top: CGFloat!
        let trail: CGFloat!
        if totalSize.height >= 890 {
            top = 45
            trail = 15
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
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
        btn.layer.zPosition = 6
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
        
        let vc = StretchingMenuViewController()
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
        guard let controller = segue.destination as? StretchingViewController else { return }

        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        controller.stretching = selectedTransform
    }
//MARK: StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
//MARK: - TableView
extension StretchingTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if choiceMuscle == 2 {
            return flexibleBack.count
        } else if choiceMuscle == 3 {
            return sideSplits.count
        } else if choiceMuscle == 4 {
            return longTwine.count
        }
        return warmUp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transformCell") as? StretchingTableViewCell else { return UITableViewCell() }
        
        if choiceMuscle == 1 {
            let stretching = warmUp[indexPath.row]
            cell.stretchingImageView.image = stretching.image
            cell.stretchingLabel1.text = stretching.text1
            cell.stretchingLabel2.text = stretching.text2
            cell.layer.zPosition = 10
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 2 {
            let stretching = flexibleBack[indexPath.row]
            cell.stretchingImageView.image = stretching.image
            cell.stretchingLabel1.text = stretching.text1
            cell.stretchingLabel2.text = stretching.text2
            cell.layer.zPosition = 10
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 3 {
            let stretching = sideSplits[indexPath.row]
            cell.stretchingImageView.image = stretching.image
            cell.stretchingLabel1.text = stretching.text1
            cell.stretchingLabel2.text = stretching.text2
            cell.layer.zPosition = 10
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceMuscle == 4 {
            let stretching = longTwine[indexPath.row]
            cell.stretchingImageView.image = stretching.image
            cell.stretchingLabel1.text = stretching.text1
            cell.stretchingLabel2.text = stretching.text2
            cell.layer.zPosition = 10
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
            selectedTransform = warmUp[indexPath.row]
        } else if choiceMuscle == 2 {
            selectedTransform = flexibleBack[indexPath.row]
        } else if choiceMuscle == 3 {
            selectedTransform = sideSplits[indexPath.row]
        } else if choiceMuscle == 4 {
            selectedTransform = longTwine[indexPath.row]
        }
        UserDefaults.standard.set(indexPath.row, forKey: "currentIndexStretchingWorkout")
        
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedExercise: Stretching
        
        switch self.choiceMuscle {
        case 1:
            selectedExercise = self.warmUp[indexPath.row]
        case 2:
            selectedExercise = self.flexibleBack[indexPath.row]
        case 3:
            selectedExercise = self.sideSplits[indexPath.row]
        case 4:
            selectedExercise = self.longTwine[indexPath.row]
        default:
            selectedExercise = self.sideSplits[indexPath.row]
        }
        
        let isChosen = chosenExercisesStretching?.contains(where: { $0 == selectedExercise.video })
        
        let chosenAction = UIContextualAction(style: .normal, title: "", handler: { (action, view, boolValue) in
            if isChosen == nil {
                self.chosenExercisesStretching = [String]()
            }
            
            if isChosen == true {
                guard let chosenIndex = self.chosenExercisesStretching?.firstIndex(where: { $0 == selectedExercise.video }) else { return }
                
                self.deletedWorkoutImage.isHidden = false
                self.deletedWorkoutImage.zoomInInfo()
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.deletedWorkoutImage.zoomOutInfo()
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.deletedWorkoutImage.isHidden = true
                    }
                }
                
                self.chosenExercisesStretching?.remove(at: chosenIndex)
                
            } else {
                self.succesImage.isHidden = false
                self.succesImage.zoomInInfo()
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.succesImage.zoomOutInfo()
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.succesImage.isHidden = true
                    }
                }
                self.chosenExercisesStretching?.append(selectedExercise.video)
            }
            
            UserDefaults.standard.set(self.chosenExercisesStretching, forKey: "chosenExercisesStretching")
            tableView.reloadRows(at: [indexPath], with: .automatic)
//            tableView.reloadData()
        })
        
        if isChosen == true {
            chosenAction.image = #imageLiteral(resourceName: "trash")
            chosenAction.backgroundColor = #colorLiteral(red: 0.780459702, green: 0.2858942747, blue: 0.286295712, alpha: 1)
        } else {
            chosenAction.image = #imageLiteral(resourceName: "heartWhite")
            chosenAction.backgroundColor = #colorLiteral(red: 0.8649404645, green: 0.5549386144, blue: 0.5683997273, alpha: 1)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [chosenAction])
        swipeActions.performsFirstActionWithFullSwipe = false
        
        return swipeActions
    }
}

//MARK: - ExtensionIronSource
extension StretchingTableViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
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
