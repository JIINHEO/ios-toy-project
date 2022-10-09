import Foundation
import RxSwift


print("----Just----")

// Observable은 구독을 하지 않으면 아무런 역할도 하지 않음
Observable<Int>.just(1) // Int를 방출할 observable / just 는 하나의 요소만 방출 -> observable 1이라는 엘리멘트만 내뿜는 시퀀스가 완성
    .subscribe(onNext: { // 서브스크라이브를 해줘야함
        print($0)
    })

print("----Of1----")
Observable<Int>.of(1, 2, 3, 4, 5) // 각 엘리멘트들을 순차적으로 내뿜는 시퀀스
    .subscribe(onNext: { // 서브스크라이브를 해줘야함
        print($0)
    })

print("----Of2----")
Observable.of([1, 2, 3, 4, 5]) // 하나의 어레이를 내뿜는것이라 사실상 just와 동일하다.
    .subscribe(onNext: { // 서브스크라이브를 해줘야함
        print($0)
    })
print("----From----")
Observable.from([1, 2, 3, 4, 5]) // 어레이만 받음 -> 어레이 속에 있는 엘리멘트를 하나씩 방출
    .subscribe(onNext: {
        print($0)
    })


print("-----subscribe1-----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("-----subscribe2-----")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("----subscribe3----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    } )

print("----empty1----")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("----empty2----")
// 이거와 동일하다
Observable<Void>.empty()
    .subscribe(onNext: {
        
    },
               onCompleted: {
        print("Completed")
    })

print("----never----")
Observable<Void>.never() // 작동은 하는데 아무런것도 내뱉지 않음
    .debug("never")
    .subscribe(onNext: {
        print($0)
    },
               onCompleted: {
        print("Completed")
    })


print("----range----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2 * \($0) = \(2*$0)")
    })

print("----dispose----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .dispose() // 구독 취소

print("----disposeBag-----")

let disposeBag = DisposeBag()
// disposebag = subscribe에서 방출된 return값을 disposebag에 가지고 있다가 자신이 할당해제할때 모든 구독(subscribe)에 대해서 dispose를 날림
// 구독할때마다 이렇게 disposebag에 넣는 방식이 귀찮아 보이기도 하는데
// 수동적으로 하다가 빼먹으면 Observable이 끝나지 않아서 메모리 누수가 일어나게됨
// 그래서 밑에처럼 항상 해주는게 좋다!

Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)


print("----create1----")
// create 는 escaping clouser다
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2) // 위에서 completed를 해서 Observable이 종료되어있기 때문에 방출되지 않음
    return Disposables.create()
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)


print("----create2----")
enum MyError: Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
} onError: {
    print($0.localizedDescription)
} onCompleted: {
    print("Completed")
} onDisposed: {
    print("disposed")
}
.disposed(by: disposeBag  )


print("----defferd1-----") // 각 구독에게 새롭게 옵져버블 항목을 제공하는 옵져버블 팩토리를 만드는...
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("----defferd2-----")
var 뒤집기: Bool = false

let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("hi~~")
    } else {
        return Observable.of("bye~~")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
