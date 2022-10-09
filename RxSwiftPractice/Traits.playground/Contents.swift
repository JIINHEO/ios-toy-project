import RxSwift
import Dispatch

let disposeBag = DisposeBag()

enum TraitsError: Error {
case single
case maybe
case Completable
}

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
{"name": "park}
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

//decode(json: json1)
//    .subscribe {
//        switch $0 {
//        case .success(let json):
//            print(json.name)
//        case .failuer(
//        }
//    } onFailure: { <#Error#> in
//        <#code#>
//    } onDisposed: {
//        <#code#>
//    }
//
//decode(json: json2)
