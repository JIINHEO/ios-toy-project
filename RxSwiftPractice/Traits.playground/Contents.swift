import RxSwift
import Dispatch

let disposeBag = DisposeBag()

enum TraitsError: Error {
case single
case maybe
case Completable
}

// 좀 더 직관적이고 명시적인 코드 작성을 위해 좀 더 제한적인 역할을 위해 제공 


print("----Single1----")
Single<String>.just("Check~")
    .subscribe {
        print($0)
    } onFailure: {
        print("error: \($0)")
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disposeBag)

print("----Single2----")
Observable<String>
    .create({ observer -> Disposable in
        observer.onError(TraitsError.single)
        return Disposables.create()
    })
    .asSingle() // 이렇게 만들어줄수도있다.
    .subscribe {
        print($0)
    } onFailure: {
        print("error: \($0)")
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disposeBag)


print("----Single3----")
struct SomeJSON: Decodable {
    let name: String
}

enum JSONError: Error {
case decodingError
}

let json1 = """
{"name": "park"}
"""

let json2 = """
{"my_name": "young"}
"""

func decode(json: String) -> Single<SomeJSON> {
    Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJSON.self, from: data)
        else {
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        
        observer(.success(json))
        return Disposables.create()
    }
}

decode(json: json1)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }
    .disposed(by: disposeBag)

decode(json: json2)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }
    .disposed(by: disposeBag)


print("----Maybe1----")
Maybe<String>.just("check~")
    .subscribe {
        print($0)
    } onError: {
        print($0)
    } onCompleted: {
        print("completed")
    } onDisposed: {
        print("disposed")
    }

print("----Maybe2----")
let t = Observable<String>.create { observer -> Disposable in
    observer.onError(TraitsError.maybe)
    return Disposables.create()
}
.asMaybe()
.subscribe {
    print("성공 \($0)")
} onError: {
    print("에러 \($0)")
} onCompleted: {
    print("completed")
} onDisposed: {
    print("Disposed")
}
.disposed(by: disposeBag)

print("-----Competable1-----")
Completable.create { observer -> Disposable in
    observer(.error(TraitsError.Completable))
    return Disposables.create()
}
.subscribe {
    print("Completed")
} onError: {
    print("error: \($0)")
} onDisposed: {
    print("disposed")
}

.disposed(by: disposeBag)

print("-----Competable-----")
Completable.create { observer -> Disposable in
    observer(.completed)
    return Disposables.create()
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)
