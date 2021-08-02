# 이전화면으로 값 전달하기


<img width="30%" src="https://user-images.githubusercontent.com/39071796/127859811-b0815272-096b-41b4-852c-508a52201da6.gif"/>


## 직접 값을 주고 받기
* ### VC1 -> VC2  
VC2의 **viewDidLoad()** 메소드 내에 작성   
(화면이 처음 만들어질 때 호출)

* ### VC2 -> VC1   
VC1의 **viewWillAppear(_:)** 메소드 내에 작성   
(뷰 컨트롤러의 뷰가 화면에 표시될 때마다 실행)

##  문제 및 해결
* ### 문제
VC2 -> VC1 로 화면이 전환되었을때 viewWillAppear의 호출과 값의 변경이 이루어지지 않았다.

* ### 해결

iOS 13부터 ```Modal presentation Style```의 디폴트 값이 full screen이 아닌 ```automatic``` 으로 변경되면서 라이프 사이클도 변경되었다.  

* 기존 fullscreen style 라이프 스타일    
dismiss -> VC2 종료 -> VC1의 viewWillAppear, viewDidAppear을 호출

* 변경된 sheet style 모달 라이프 사이클   
VC1에 전혀 영향을 주지 않고 앞에 독립적으로 띄워짐 -> dismiss -> VC2 종료


```애초에 <임시로> 모달을 띄운 형태인데 VC1메소드에서 뭔가를 해야하는것은 바람직하지 않은것 같다.```
