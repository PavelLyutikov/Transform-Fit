//
//  PostPregnancyRecoveryTableViewController.swift
//  Transform
//
//  Created by Pavel Lyutikov on 03.06.2021.
//

import UIKit
import CachingPlayerItem

class PostPregnancyRecoveryTableViewController: UIViewController {
    
    var choiceSection = UserDefaults.standard.integer(forKey: "choiceSection")

    let totalSize = UIScreen.main.bounds.size
    
    var chosenExercisesPostPregnancyRecovery = UserDefaults.standard.array(forKey: "chosenExercisesPostPregnancyRecovery") as? [String]
    
    var openNextPostPregnancyRecoveryWorkout = UserDefaults.standard.bool(forKey: "openNextPostPregnancyRecoveryWorkout")
    var openBackPostPregnancyRecoveryWorkout = UserDefaults.standard.bool(forKey: "openBackPostPregnancyRecoveryWorkout")
    var currentIndexPostPregnancyRecoveryWorkout = UserDefaults.standard.integer(forKey: "currentIndexPostPregnancyRecoveryWorkout")
    
    @IBOutlet weak var postPregnancyRecoveryTableView: UITableView!
    
    //ironSource
    var bannerView: ISBannerView! = nil
    let kAPPKEY = "11dfcc91d"
    
    //Light
    private let ligth = [
        PostPregnancyRecovery(image: UIImage(named: "recovery/1")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/1")!, text1: "Диафрагмальное дыхание".localized(), text2: "СИДЯ".localized(), text3: "Примечание: \n \nДля правильного выполнения, вы можете положить одну руку на грудь, а другую на пупок. На вдохе надувается живот, рука лежащая на пупке, поднимается вверх, на выдохе — опускается вниз. При этом грудь остается неподвижной — рука на груди соответственно тоже. Сократите количество вдохов, если вам это даётся трудно. Когда вы сможете это делать не напрягаясь, попробуйте так дышать все время, диафрагмальное дыхание должно войти в привычку и происходить непроизвольно.".localized(), text4: "8-10 вдохов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FLight%2F1.mp4?alt=media&token=b85fcecf-2c9c-4ad3-9dcf-87a331dfadcb"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/2")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/2")!, text1: "Касание носков пола".localized(), text2: "НА КАЖДУЮ НОГУ".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. На выдохе касайтесь носком пола, со вдохом, напрягая пресс возвращайте ногу в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "8-10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FLight%2F2.mp4?alt=media&token=61e492f6-0174-4d14-a319-23d4ad23b162"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/3")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/3")!, text1: "Скольжение".localized(), text2: "НА КАЖДУЮ НОГУ".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. На выдохе скользите пяткой по полу, до тех пор, пока поясница будет оставаться прижатой к полу. Со вдохом, напрягая пресс, возвращайте ногу в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "10-12 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FLight%2F3.mp4?alt=media&token=299b1229-feb8-4f45-b60d-cb566783b595"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/4")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/4")!, text1: "Подъем ног".localized(), text2: "НА КАЖДУЮ НОГУ".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. Положите руки на живот, выполните «диафрагмальное дыхание» 1-2 вдоха. На выдохе опускайте ногу, до тех пор, пока поясница будет оставаться прижатой к полу. Со вдохом, напрягая пресс, возвращайте ногу в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "10-12 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FLight%2F4.mp4?alt=media&token=9acd7786-9127-4362-897e-039b643220da"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/5")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/5")!, text1: "Вращение ногой".localized(), text2: "НА КАЖДУЮ НОГУ".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. Во время упражнения таз остаётся неподвижен. На выдохе выполните круговое движение ногой. Со вдохом, напрягая пресс, возвращайте в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "15-20 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FLight%2F5.mp4?alt=media&token=3640fe63-645c-4126-80aa-edc7b0eabd92"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/8")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/8")!, text1: "Выпрямление ног".localized(), text2: "ОТ СЕБЯ".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. На выдохе выпрямите ноги. Со вдохом, колени направлены в стороны, возвращайте в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "8-10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FLight%2F8.mp4?alt=media&token=f522a2ad-0b30-44a8-b8ae-0a3c54e97a2e"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/16")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/16")!, text1: "Подтягивание ноги к себе".localized(), text2: "НА КАЖДУЮ НОГУ".localized(), text3: "Примечание: \n \nПоясница прижата к полу. На выдохе подтяните ногу к себе, стараясь напрячь мышцы пресса. Со вдохом, возвращайте в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна прогибаться, не должно быть дискомфорта и болевых ощущений.".localized(), text4: "5-8 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FLight%2F16.mp4?alt=media&token=097c8c6e-7d88-4d58-8949-4c399f48f5fa"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/18")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/18")!, text1: "Диафрагмальное дыхание".localized(), text2: "ЛЁЖА".localized(), text3: "Примечание: \n \nДля правильного выполнения, вы можете положить одну руку на грудь, а другую на пупок. На вдохе надувается живот, рука лежащая на пупке, поднимается вверх, на выдохе — опускается вниз. При этом грудь остается неподвижной — рука на груди соответственно тоже. Сократите количество вдохов, если вам это даётся трудно. Когда вы сможете это делать не напрягаясь, попробуйте так дышать все время, диафрагмальное дыхание должно войти в привычку и происходить непроизвольно.".localized(), text4: "8-10 вдохов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FLight%2F18.mp4?alt=media&token=a00e35fd-be5c-449b-b0bf-b3ed5e4a688f")]
    //Midle
    private let midle = [
        PostPregnancyRecovery(image: UIImage(named: "recovery/9")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/9")!, text1: "Касание носков пола".localized(), text2: "В ПОДЪЁМЕ".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. На выдохе касайтесь носком пола, со вдохом, напрягая пресс возвращайте ногу в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "8-10 наклонов".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F9.mp4?alt=media&token=22f2724f-8641-4e6b-baae-4eeb7d73888e"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/10")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/10")!, text1: "Боковая планка".localized(), text2: "НА КАЖДУЮ СТОРОНУ".localized(), text3: "Примечание: \n \nКорпус ровный, все суставы на одной линии. Опорная рука перпендикулярна полу. Живот в напряжении. С выдохом приподнимаем корпус и удерживаем его в этом положении. Взгляд направлен прямо.".localized(), text4: "10-15 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F10.mp4?alt=media&token=0be5f55a-de6e-4a1f-9b10-d79b4fcb7162"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/12")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/12")!, text1: "Лодочка".localized(), text2: "СО СВЕДЕНИЕМ ЛОПАТОК".localized(), text3: "Примечание: \n \nШея на одной линии с позвоночником. На выдохе приподнимите грудной отдел и сведите лопатки, на входе вернитесь в исходное положение, расслабьтесь.".localized(), text4: "3х20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F12.mp4?alt=media&token=77a72d3b-711f-4482-9240-0d1d3e5dfd94"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/14")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/14")!, text1: "Спинной баланс".localized(), text2: "НА КАЖДУЮ СТОРОНУ".localized(), text3: "Примечание: \n \nВстаньте на четвереньки. Живот в напряжении. Спина прямая, шея на одной линии с позвоночником. С выдохом, напрягая мышцы пресса приведите правую ногу к левому локтю, затем аналогично с другой стороны. Работайте в своей амплитуде. Во время упражнения спина прямая.".localized(), text4: "10-12 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F14.mp4?alt=media&token=845c7f45-8462-45e3-9902-721ae76d511d"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/17")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/17")!, text1: "Касание носков".localized(), text2: "ПОЛА".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. На выдохе касайтесь носком пола, со вдохом, напрягая пресс возвращайте ногу в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "8-10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F17.mp4?alt=media&token=19a9214f-093c-4369-8b07-7b630612705e"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/19")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/19")!, text1: "Кошка".localized(), text2: "С НЕЙТРАЛЬНЫМ ПОЛОЖЕНИЕМ".localized(), text3: "Примечание: \n \nВстаньте на четвереньки. Исходное положение - спина прямая, шея на одной линии с позвоночником. С выдохом, максимально округлите спину, вытягивайте позвонок за позвонком, на вдохе вернитесь в исходное положение, не прогибайтесь в пояснице, старайтесь держать мышцы пресса в напряжении.".localized(), text4: "8-10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F19.mp4?alt=media&token=1808e173-3b3c-418f-bfb5-a6f1f787bed0"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/22")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/22")!, text1: "Ягодичный мостик".localized(), text2: "СТОЯ".localized(), text3: "Примечание: \n \nСпина прямая, живот в тонусе, лопатки прижаты к полу. Таз слегка подкручен. Толкнитесь пятками, оторвите таз от пола. Не прогибайтесь в спине и старайтесь лопатки не отрывать от пола, сожмите ягодицы на подъеме, затем вернитесь в исходное положение.".localized(), text4: "3х20-25", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F22.mp4?alt=media&token=807594be-68f7-4011-89fe-cea93a03d10d"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/24")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/24")!, text1: "Приведение бедра".localized(), text2: "НА КАЖДУЮ НОГУ".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Во время упражнения таз остаётся неподвижен. На вдохе отведите ногу в сторону, но так, что бы таз остался на месте. Затем с выдохом возвращайте в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "3х15-20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F24.mp4?alt=media&token=f3ffc4d8-4f8d-454b-8d88-4bf0d1f97e6c"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/27")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/27")!, text1: "Боковое отведение".localized(), text2: "НА КАЖДУЮ НОГУ".localized(), text3: "Примечание: \n \nОпорная рука перпендикулярна полу. Взгляд прямо. Мышцы пресса в напряжении. С выдохом поднимите бедро наверх, со вдохом вернитесь в исходное положение.".localized(), text4: "3х15-20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F27.mp4?alt=media&token=ddc93ce1-840e-4a20-8975-8616876666b2"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/34")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/34")!, text1: "Выпрямление ноги".localized(), text2: "ПООЧЕРЁДНО".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. Положите руки на живот , выполните «диафрагмальное дыхание» 1-2 вдоха. На выдохе опускайте ногу, до тех пор, пока поясница будет оставаться прижатой к полу. Со вдохом, напрягая пресс, возвращайте ногу в исходное положение. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "8-10 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F34.mp4?alt=media&token=1ed0c579-e433-4c5e-ab03-6d63935b7142"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/35")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/35")!, text1: "Ягодичный мостик".localized(), text2: "СО СВЕДЕНИЕМ".localized(), text3: "Примечание: \n \nСпина прямая, живот в тонусе, лопатки прижаты к полу. Таз слегка подкручен. Толкнитесь пятками, оторвите таз от пола, сожмите ягодичные мышцы и сведите колени, напрягая приводящие мышцы. \n \nНе прогибайтесь в спине и старайтесь лопатки не отрывать от пола, затем вернитесь в исходное положение.".localized(), text4: "3х20-30", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FMidle%2F35.mp4?alt=media&token=0f123677-3923-4f52-bf39-334b6a22d245"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/37")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/37")!, text1: "Боковая планка".localized(), text2: "НА КАЖДУЮ СТОРОНУ".localized(), text3: "Примечание: \n \nКорпус ровный, все суставы на одной линии. Опорная рука перпендикулярна полу. Живот в напряжении. С выдохом плавно скручиваемся, взгляд по направлению руки, со вдохом возвращаемся в исходное положение.".localized(), text4: "6-8 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F37.mp4?alt=media&token=04024318-8d68-4984-8063-22d498578ad7")]
    //Hard
    private let hard = [
        PostPregnancyRecovery(image: UIImage(named: "recovery/11")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/11")!, text1: "Боковая планка".localized(), text2: "НА КАЖДУЮ СТОРОНУ".localized(), text3: "Примечание: \n \nКорпус ровный, все суставы на одной линии. Опорная рука перпендикулярна полу. Живот в напряжении. С выдохом приподнимаем корпус и удерживаем его в этом положении. Взгляд направлен прямо.".localized(), text4: "10-15 секунд".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F11.mp4?alt=media&token=b554fd88-fd3c-4875-a841-47d51a95eddf"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/15")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/15")!, text1: "Спинной баланс".localized(), text2: "НА КАЖДУЮ СТОРОНУ".localized(), text3: "Примечание: \n \nВстаньте на четвереньки. Живот в напряжении. Спина прямая, шея на одной линии с позвоночником. С выдохом, напрягая мышцы пресса приведите правую ногу к левому локтю, затем аналогично с другой стороны. Работайте в своей амплитуде. Во время упражнения спина прямая.".localized(), text4: "10-12 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F15.mp4?alt=media&token=6e278900-5c37-417e-8f0d-fdc95aa4b097"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/20")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/20")!, text1: "Мах ногой".localized(), text2: "НА КАЖДУЮ НОГУ".localized(), text3: "Примечание: \n \nВстаньте на четвереньки. Живот в напряжении. Спина прямая, шея на одной линии с позвоночником. С выдохом, напрягая мышцы пресса, приведите ногу к корпусу, со вдохом возвращаем в исходное положение, затем аналогично с другой стороны. Работайте в своей амплитуде, отводя ногу назад, контролируйте спину, держите ее прямой.".localized(), text4: "3х15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F20.mp4?alt=media&token=60583c2a-8101-4903-a6ca-1b7a934f822f"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/21")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/21")!, text1: "Повороты корпуса".localized(), text2: "НА КАЖДУЮ СТОРОНУ".localized(), text3: "Примечание: \n \nСпина ровная. Если вам трудно выполнять без опоры, вы можете на что-нибудь облокотиться. Со вдохом поверните корпус, с выдохом, напрягая мышцы пресса вернитесь в исходное положение.".localized(), text4: "3х10-12", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F21.mp4?alt=media&token=92e6610b-3b68-413a-ba69-42a60cc886e6"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/23")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/23")!, text1: "Ягодичный мостик".localized(), text2: "ПО ОДНОЙ НОГЕ".localized(), text3: "Примечание: \n \nСпина прямая, лопатки прижаты к полу, живот в тонусе. Таз слегка подкручен. Одна нога находится прямой или согнутой в колене, другая стоит на полу и служит точкой опоры. Толкнитесь пяткой опорной ноги, оторвите таз от пола. Не прогибайтесь в спине и старайтесь лопатки не отрывать от пола, сожмите ягодицы на подъеме, затем вернитесь в исходное положение.".localized(), text4: "3х12-15", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F23.mp4?alt=media&token=a34f43a8-c6e9-476a-87ac-58d888dec400"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/25")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/25")!, text1: "Мах ногой".localized(), text2: "ВПЕРЁД".localized(), text3: "Примечание: \n \nВстаньте на четвереньки. Живот в напряжении. Спина прямая, шея на одной линии с позвоночником. С выдохом, держа мышцы пресса, ответите ногу, напрягите ягодичную мышцу. Со вдохом возвращаем в исходное положение, затем аналогично с другой стороны. Работайте в своей амплитуде, отводя ногу назад, контролируйте спину, держите ее прямой.".localized(), text4: "3х15-20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F25.mp4?alt=media&token=1a14189a-852b-4061-9c60-50df6b11d96c"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/26")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/26")!, text1: "Обратная планка".localized(), text2: "С ОТВЕДЕНИЕМ БЕДРА".localized(), text3: "Примечание: \n \nПоложение обратной планки. Руки прямые, спина прямая, мышцы пресса в напряжении. Угол в колене опорной ноги 90 градусов. С выдохом отведите бедро в строну, на столько на сколько это возможно. Со вдохом вернитесь в исходное положение, затем аналогично с другой стороны.".localized(), text4: "3х5-8", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F26.mp4?alt=media&token=bb1688e2-36de-4797-900e-d563d62e82ee"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/28")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/28")!, text1: "Диагональное отведение".localized(), text2: "ПООЧЕРЁДНО РУК И НОГ".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. На выдохе опустите левую ногу и правду ногу вниз. Затем со вдохом возвращайте в исходное положение и аналогично с другой стороны. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола.".localized(), text4: "3х12-20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F28.mp4?alt=media&token=3011aab6-358b-46f1-9da7-dbe2f7c9eae4"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/30")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/30")!, text1: "Приседания".localized(), text2: "КЛАССИЧЕСКИЕ".localized(), text3: "Примечание: \n \nИсходное положение ноги чуть шире ширины плеч. Носки чуть врозь. Колени сонаправлены с носками. Мышцы пресса в тонусе. На вдохе опускаемся вниз примерно по параллели с полом. Акцент на пятках, со вдохом возвращаемся в исходное положение.".localized(), text4: "3х15-20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F30.mp4?alt=media&token=6b92905b-8bc3-4b03-98c8-1a1a73a25df2"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/31")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/31")!, text1: "Книжка".localized(), text2: "".localized(), text3: "Примечание: \n \nПоясница плотно прижата к полу. Таз слегка подкручен. Со вдохом опустите ноги и руки вниз. Затем на выдохе возвращайте в исходное положение, сокращая мышцы пресса. \n \nКонтролируйте поясницу, во время упражнений, она не должна отрываться от пола. Первое время можно выполнять без отягощения.".localized(), text4: "3х15-20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F31.mp4?alt=media&token=86bac923-f37e-41e1-a14c-69275c721748"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/32")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/32")!, text1: "Махи через стороны".localized(), text2: "СИДЯ".localized(), text3: "Примечание: \n \nСпина прямая, живот в напряжении. Руки в локтях чуть согнуты, на выдохе поднимите руки через стороны, шея расслаблена. Со вдохом вернитесь в исходное положение.".localized(), text4: "3х15-20", video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F32.mp4?alt=media&token=8fe892e8-f10f-45ae-8a71-620c1da238fa"),
        PostPregnancyRecovery(image: UIImage(named: "recovery/36")!, imageBackground: UIImage(named: "recovery/recoveryVideoBackground/36")!, text1: "Боковая планка".localized(), text2: "НА КАЖДУЮ СТОРОНУ".localized(), text3: "Примечание: \n \nКорпус ровный, все суставы на одной линии. Опорная рука перпендикулярна полу. Живот в напряжении. С выдохом плавно скручиваемся, взгляд по направлению руки, со вдохом возвращаемся в исходное положение.".localized(), text4: "6-8 повторений".localized(), video: "https://firebasestorage.googleapis.com/v0/b/transform-715ad.appspot.com/o/Recovery%2FHard%2F36.mp4?alt=media&token=6d050b9e-63c4-4197-83c9-37212b9cbcd7")]
    
    private var selectedTransform: PostPregnancyRecovery?

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
        
        postPregnancyRecoveryTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positY)
        }
        postPregnancyRecoveryTableView.layer.zPosition = 5
        
        let customFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        customFooterView.backgroundColor = .clear

        self.postPregnancyRecoveryTableView.tableFooterView = customFooterView
        
        setNavBarToTheView()
        
        navigationController?.isNavigationBarHidden = true
            
        dismissButton.addTarget(self, action: #selector(buttonDismiss), for: .touchUpInside)
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            if self.openNextPostPregnancyRecoveryWorkout == true {
            UserDefaults.standard.set(false, forKey: "openNextPostPregnancyRecoveryWorkout")
            self.nextWorkout()
            }
            if self.openBackPostPregnancyRecoveryWorkout == true {
            UserDefaults.standard.set(false, forKey: "openBackPostPregnancyRecoveryWorkout")
            self.backWorkout()
            }
        }
        
        //Ads
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
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionPPRecovery12ProMax"))
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionPPRecovery"))
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionPPRecovery12"))
        } else if totalSize.height == 812 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionPPRecovery12Mini"))
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionPPRecovery7+"))
        } else if totalSize.height <= 670 {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionPPRecoveryMin"))
        } else {
            img = UIImageView(image: #imageLiteral(resourceName: "imageBackgroundTransitionPPRecovery12Mini"))
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
        let indexPath = IndexPath(item: currentIndexPostPregnancyRecoveryWorkout + 1, section: 0)
        
        var countList = IndexPath()
        
        if choiceSection == 1 {
            countList = IndexPath(item: ligth.count - 1, section: 0)
        } else if choiceSection == 2 {
            countList = IndexPath(item: midle.count - 1, section: 0)
        } else if choiceSection == 3 {
            countList = IndexPath(item: hard.count - 1, section: 0)
        }
        
        let countListBack = IndexPath(item: 2, section: 0)
        
        if indexPath <= countList {
            if openNextPostPregnancyRecoveryWorkout == true {
                imageBackgroundTransition.isHidden = false
            }
        }
        if indexPath >= countListBack {
            if openBackPostPregnancyRecoveryWorkout == true {
                imageBackgroundTransition.isHidden = false
            }
        }
    }
//MARK: - NextWorkout
     func nextWorkout() {
        let indexPath = IndexPath(item: currentIndexPostPregnancyRecoveryWorkout + 1, section: 0)
        
        var countList = IndexPath()
        
        if choiceSection == 1 {
            countList = IndexPath(item: ligth.count - 1, section: 0)
        } else if choiceSection == 2 {
            countList = IndexPath(item: midle.count - 1, section: 0)
        } else if choiceSection == 3 {
            countList = IndexPath(item: hard.count - 1, section: 0)
        }
        
        if indexPath <= countList {
            
        destroyBanner()
        
        UserDefaults.standard.set(indexPath.row, forKey: "currentIndexPostPregnancyRecoveryWorkout")

        if choiceSection == 1 {
            selectedTransform = ligth[indexPath.row]
        } else if choiceSection == 2 {
            selectedTransform = midle[indexPath.row]
        } else if choiceSection == 3 {
            selectedTransform = hard[indexPath.row]
        }
            UserDefaults.standard.set(true, forKey: "isOpenRecovery")

        performSegue(withIdentifier: "postPregnancyRecoverySegue", sender: nil)
        }
    }
//MARK: - BackWorkout
     func backWorkout() {
        let indexPath = IndexPath(item: currentIndexPostPregnancyRecoveryWorkout - 1, section: 0)
        
        let countList = IndexPath(item: 0, section: 0)
        
        if indexPath >= countList {
        
        destroyBanner()
            
        UserDefaults.standard.set(indexPath.row, forKey: "currentIndexPostPregnancyRecoveryWorkout")

        if choiceSection == 1 {
            selectedTransform = ligth[indexPath.row]
        } else if choiceSection == 2 {
            selectedTransform = midle[indexPath.row]
        } else if choiceSection == 3 {
            selectedTransform = hard[indexPath.row]
        }
            
            UserDefaults.standard.set(true, forKey: "isOpenRecovery")

        performSegue(withIdentifier: "postPregnancyRecoverySegue", sender: nil)
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
        
        switch self.choiceSection {
        case 1:
            navItem.title = "Light"
        case 2:
            navItem.title = "Midle"
        case 3:
            navItem.title = "Hard"
        default:
            navItem.title = ""
        }
        
        
        navBar.setItems([navItem], animated: true)
    }
//MARK: BackgroundImage
    lazy var backgroundImage: UIImageView = {
        let lead: CGFloat!
        let height: CGFloat!
        if totalSize.height >= 920 {
            lead = -430
            height = 800
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            lead = -430
            height = 800
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            lead = -440
            height = 750
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            lead = -450
            height = 670
        } else if totalSize.height <= 670 {
            lead = -460
            height = 600
        } else {
            lead = -440
            height = 700
        }
        
        let img = UIImageView(image: #imageLiteral(resourceName: "recoveryMenuImage"))
        img.contentMode = .scaleAspectFit
        img.alpha = 0.2
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 5
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(lead)
            make.bottom.equalToSuperview().inset(0)
            make.height.equalTo(height)
        }
        
        return img
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
        
        let vc = MenuPostPregnancyRecoveryViewController()
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
        guard let controller = segue.destination as? PostPregnancyRecoveryViewController else { return }

        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        controller.postPregnancyRecovery = selectedTransform
    }
//MARK: StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
//MARK: - TableView
extension PostPregnancyRecoveryTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if choiceSection == 2 {
            return midle.count
        } else if choiceSection == 3 {
            return hard.count
        }
        return ligth.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transformCell") as? PostPregnancyRecoveryTableViewCell else { return UITableViewCell() }
        
        if choiceSection == 1 {
            let postPregnancyRecovery = ligth[indexPath.row]
            cell.postPregnancyRecoveryImageView.image = postPregnancyRecovery.image
            cell.postPregnancyRecoveryLabel1.text = postPregnancyRecovery.text1
            cell.postPregnancyRecoveryLabel2.text = postPregnancyRecovery.text2
            cell.layer.zPosition = 10
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceSection == 2 {
            let postPregnancyRecovery = midle[indexPath.row]
            cell.postPregnancyRecoveryImageView.image = postPregnancyRecovery.image
            cell.postPregnancyRecoveryLabel1.text = postPregnancyRecovery.text1
            cell.postPregnancyRecoveryLabel2.text = postPregnancyRecovery.text2
            cell.layer.zPosition = 10
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        } else if choiceSection == 3 {
            let postPregnancyRecovery = hard[indexPath.row]
            cell.postPregnancyRecoveryImageView.image = postPregnancyRecovery.image
            cell.postPregnancyRecoveryLabel1.text = postPregnancyRecovery.text1
            cell.postPregnancyRecoveryLabel2.text = postPregnancyRecovery.text2
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
        
        if choiceSection == 1 {
            selectedTransform = ligth[indexPath.row]
        } else if choiceSection == 2 {
            selectedTransform = midle[indexPath.row]
        } else if choiceSection == 3 {
            selectedTransform = hard[indexPath.row]
        }
        UserDefaults.standard.set(indexPath.row, forKey: "currentIndexPostPregnancyRecoveryWorkout")
        
        UserDefaults.standard.set(true, forKey: "isOpenRecovery")
        
        performSegue(withIdentifier: "postPregnancyRecoverySegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedExercise: PostPregnancyRecovery
        
        switch self.choiceSection {
        case 1:
            selectedExercise = self.ligth[indexPath.row]
        case 2:
            selectedExercise = self.midle[indexPath.row]
        case 3:
            selectedExercise = self.hard[indexPath.row]
        default:
            selectedExercise = self.ligth[indexPath.row]
        }
        
        let isChosen = chosenExercisesPostPregnancyRecovery?.contains(where: { $0 == selectedExercise.video })
        
        let chosenAction = UIContextualAction(style: .normal, title: "", handler: { (action, view, boolValue) in
            if isChosen == nil {
                self.chosenExercisesPostPregnancyRecovery = [String]()
            }
            
            if isChosen == true {
                guard let chosenIndex = self.chosenExercisesPostPregnancyRecovery?.firstIndex(where: { $0 == selectedExercise.video }) else { return }
                
                self.deletedWorkoutImage.isHidden = false
                self.deletedWorkoutImage.zoomInInfo()
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.deletedWorkoutImage.zoomOutInfo()
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.deletedWorkoutImage.isHidden = true
                    }
                }
                
                self.chosenExercisesPostPregnancyRecovery?.remove(at: chosenIndex)
                
            } else {
                self.succesImage.isHidden = false
                self.succesImage.zoomInInfo()
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.succesImage.zoomOutInfo()
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                    self.succesImage.isHidden = true
                    }
                }
                self.chosenExercisesPostPregnancyRecovery?.append(selectedExercise.video)
            }
            
            UserDefaults.standard.set(self.chosenExercisesPostPregnancyRecovery, forKey: "chosenExercisesPostPregnancyRecovery")
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
extension PostPregnancyRecoveryTableViewController: ISBannerDelegate, ISImpressionDataDelegate {
    
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
