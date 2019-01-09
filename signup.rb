require 'selenium-webdriver'

Selenium::WebDriver::Chrome.driver_path = `which chromedriver-helper`.chomp # 설치한 크롬 드라이버 사용
options = Selenium::WebDriver::Chrome::Options.new # 크롬 헤드리스 모드 위해 옵션 설정
options.add_argument('--disable-gpu') # 크롬 헤드리스 모드 사용 위해 disable-gpu setting
options.add_argument('--headless') # 크롬 헤드리스 모드 사용 위해 headless setting
@browser = Selenium::WebDriver.for :chrome, options: options # 실레니움 + 크롬 + 헤드리스 옵션으로 브라우저 실행



#회원가입 페이지로 이동
signUp_url = 'https://www.bikeseoul.com/memberRegSelect.do?appOsType='
@browser.get signUp_url


#일반회원/네이버/페이스북/카카오 중 택1
print "input your sign up type : "
signUp_type = gets.chomp 
if signUp_type == 1 #일반회원으로 가입
    @browser.navigate.to "https://www.bikeseoul.com/memberReg.do"
   
    phone1_input =  "//*[@id=\"/html/body/div[1]/div[2]/div/div/form/div[1]/label[1]/input\"]" # 핸드폰번호 첫자리 입력 부분
    phone2_input =  "//*[@id=\"/html/body/div[1]/div[2]/div/div/form/div[1]/label[2]/input\"]" # 핸드폰번호 중간자리 입력 부분
    phone3_input =  "//*[@id=\"/html/body/div[1]/div[2]/div/div/form/div[1]/label[3]/input\"]" # 핸드폰번호 마직막자리 입력 부분
     
    inputID = @browser.find_element(xpath: phone1_input)
    inputID.send_keys "010" # 핸드폰번호 첫자리 입력
    
    inputID = @browser.find_element(xpath: phone2_input)
    inputID.send_keys "1234" # 핸드폰번호 중간자리 입력
    
    inputID = @browser.find_element(xpath: phone3_input)
    inputID.send_keys "5678" # 핸드폰번호 마지막자리 입력

    @browser.find_element(xpath: "/html/body/div[1]/div[2]/div/div/form/div[2]/label/span").click #만15세 이상입니다.
    
    
elseif signUp_type == 2 #네이버 계정으로 가입
    @browser.find_element(xpath: "/html/body/div[1]/div/div/div/div[2]/ul/li[3]/a").click 
elseif signUp_type == 3 #페이스북 계정으로 가입
    @browser.find_element(xpath: "/html/body/div[1]/div/div/div/div[2]/ul/li[4]/a").click 
else   #카카오 계정으로 가입
    @browser.find_element(xpath: "/html/body/div[1]/div/div/div/div[2]/ul/li[5]/a").click 
end
@browser.navigate.to "https://www.bikeseoul.com/memberRegClause.do"
@x = puts @browser.find_element(xpath: "/html/body/div[1]/div[2]/div/div/div[4]/p[1]/a").text #내용출력
 

@browser.quit