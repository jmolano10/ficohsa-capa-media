(:: pragma bea:global-element-parameter parameter="$registrodeRTEResponse" element="ns1:RegistrodeRTEResponse" location="../../xsds/RegistroRTE/XMLSchema_-102414330.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registrarRTEResponse" location="../../xsds/RegistrarRTE/RegistrarRTE.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/RegistrarRTEOut/";

declare function xf:RegistrarRTEOut($registrodeRTEResponse as element(ns1:RegistrodeRTEResponse))
    as element(ns0:registrarRTEResponse) {
        <ns0:registrarRTEResponse>
            {
                for $DATE in $registrodeRTEResponse/FICORTEType/DATE
                return
                    <DATE>{ data($DATE) }</DATE>
            }
            {
                for $HOUR in $registrodeRTEResponse/FICORTEType/HOUR
                return
                    <HOUR>{ data($HOUR) }</HOUR>
            }
            {
                for $TELLERTXNNO in $registrodeRTEResponse/FICORTEType/TELLERTXNNO
                return
                    <TELLER_TXN_NO>{ data($TELLERTXNNO) }</TELLER_TXN_NO>
            }
            {
                for $TRANSACTIONTYPE in $registrodeRTEResponse/FICORTEType/TRANSACTIONTYPE
                return
                    <TRANSACTION_TYPE>{ data($TRANSACTIONTYPE) }</TRANSACTION_TYPE>
            }
            {
                for $RTETXNTYPE in $registrodeRTEResponse/FICORTEType/RTETXNTYPE
                return
                    <RTE_TXN_TYPE>{ data($RTETXNTYPE) }</RTE_TXN_TYPE>
            }
            {
                for $CURRENCY in $registrodeRTEResponse/FICORTEType/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $MOVEMENTTYPE in $registrodeRTEResponse/FICORTEType/MOVEMENTTYPE
                return
                    <MOVEMENT_TYPE>{ data($MOVEMENTTYPE) }</MOVEMENT_TYPE>
            }
            {
                for $AMOUNT in $registrodeRTEResponse/FICORTEType/AMOUNT
                return
                    <AMOUNT>{ data($AMOUNT) }</AMOUNT>
            }
            {
                for $USDAMOUNT in $registrodeRTEResponse/FICORTEType/USDAMOUNT
                return
                    <USD_AMOUNT>{ data($USDAMOUNT) }</USD_AMOUNT>
            }
            {
                for $EXCHANGERATE in $registrodeRTEResponse/FICORTEType/EXCHANGERATE
                return
                    <EXCHANGE_RATE>{ data($EXCHANGERATE) }</EXCHANGE_RATE>
            }
            {
                let $result :=
                    for $ORIGINRESOURCES in $registrodeRTEResponse/FICORTEType/gORIGINRESOURCES/ORIGINRESOURCES
                    return
                        fn:normalize-space(data($ORIGINRESOURCES)) 
                return
                    <ORIGIN_RESOURCES>{ fn:string-join($result, "") }</ORIGIN_RESOURCES>
            }
            {
                for $BRANCHID in $registrodeRTEResponse/FICORTEType/BRANCHID
                return
                    <BRANCH_ID>{ data($BRANCHID) }</BRANCH_ID>
            }
            {
                for $AFFECTEDACCOUNT in $registrodeRTEResponse/FICORTEType/AFFECTEDACCOUNT
                return
                    <AFFECTED_ACCOUNT>{ data($AFFECTEDACCOUNT) }</AFFECTED_ACCOUNT>
            }
            {
                for $OWNERTXN in $registrodeRTEResponse/FICORTEType/OWNERTXN
                return
                    <OWNER_TXN>{ data($OWNERTXN) }</OWNER_TXN>
            }
            {
                for $RTEAGENCY in $registrodeRTEResponse/FICORTEType/RTEAGENCY
                return
                    <RTE_AGENCY>{ data($RTEAGENCY) }</RTE_AGENCY>
            }
            {
                let $result :=
                    for $INPUTTER in $registrodeRTEResponse/FICORTEType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ data($INPUTTER) }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $registrodeRTEResponse/FICORTEType/gDATETIME/DATETIME
                    return
                        <DATETIME>{ concat("20", $DATETIME) }</DATETIME>
                return
                    $result[1]
            }
            {
                for $AUTHORISER in $registrodeRTEResponse/FICORTEType/AUTHORISER
                return
                    <AUTHORISER>{ data($AUTHORISER) }</AUTHORISER>
            }
            {
                for $COCODE in $registrodeRTEResponse/FICORTEType/COCODE
                return
                    <CO_CODE>{ data($COCODE) }</CO_CODE>
            }
            <RTE_CLIENT>
                {
                    for $TYPEID in $registrodeRTEResponse/FICORTEType/TYPEID
                    return
                        <TYPE_ID>{ data($TYPEID) }</TYPE_ID>
                }
                {
                    for $IDNUMBER in $registrodeRTEResponse/FICORTEType/IDNUMBER
                    return
                        <ID_NUMBER>{ data($IDNUMBER) }</ID_NUMBER>
                }
                {
                    for $FULLNAME in $registrodeRTEResponse/FICORTEType/FULLNAME
                    return
                        <FULL_NAME>{ data($FULLNAME) }</FULL_NAME>
                }
                {
                    for $DATEOFBIRTH in $registrodeRTEResponse/FICORTEType/DATEOFBIRTH
                    return
                        <DATE_OF_BIRTH>{ data($DATEOFBIRTH) }</DATE_OF_BIRTH>
                }
                {
                    for $GENDER in $registrodeRTEResponse/FICORTEType/GENDER
                    return
                        <GENDER>{ data($GENDER) }</GENDER>
                }
                {
                    for $COUNTRY in $registrodeRTEResponse/FICORTEType/COUNTRY
                    return
                        <COUNTRY>{ data($COUNTRY) }</COUNTRY>
                }
                {
                    for $NATIONALITY in $registrodeRTEResponse/FICORTEType/NATIONALITY
                    return
                        <NATIONALITY>{ data($NATIONALITY) }</NATIONALITY>
                }
                {
                    for $DEPARTMENT in $registrodeRTEResponse/FICORTEType/DEPARTMENT
                    return
                        <DEPARTMENT>{ data($DEPARTMENT) }</DEPARTMENT>
                }
                {
                    for $MUNICIPALITY in $registrodeRTEResponse/FICORTEType/MUNICIPALITY
                    return
                        <MUNICIPALITY>{ data($MUNICIPALITY) }</MUNICIPALITY>
                }
                {
                    for $HOMEADDRESS in $registrodeRTEResponse/FICORTEType/HOMEADDRESS
                    return
                        <HOME_ADDRESS>{ data($HOMEADDRESS) }</HOME_ADDRESS>
                }
                {
                    for $RESIDENCENUMBER in $registrodeRTEResponse/FICORTEType/RESIDENCENUMBER
                    return
                        <RESIDENCE_NUMBER>{ data($RESIDENCENUMBER) }</RESIDENCE_NUMBER>
                }
                {
                    for $PROFESSION in $registrodeRTEResponse/FICORTEType/PROFESSION
                    return
                        <PROFESSION>{ data($PROFESSION) }</PROFESSION>
                }
                {
                    for $COMPANYNAME in $registrodeRTEResponse/FICORTEType/COMPANYNAME
                    return
                        <COMPANY_NAME>{ data($COMPANYNAME) }</COMPANY_NAME>
                }
                {
                    for $WORKPHONE in $registrodeRTEResponse/FICORTEType/WORKPHONE
                    return
                        <WORK_PHONE>{ data($WORKPHONE) }</WORK_PHONE>
                }
                {
                    for $BENERELATION in $registrodeRTEResponse/FICORTEType/BENERELATION
                    return
                        <BENE_RELATION>{ data($BENERELATION) }</BENE_RELATION>
                }
            </RTE_CLIENT>
            <RTE_BEHALF_CLIENT>
                {
                    for $BEHLFTYPEID in $registrodeRTEResponse/FICORTEType/BEHLFTYPEID
                    return
                        <TYPE_ID>{ data($BEHLFTYPEID) }</TYPE_ID>
                }
                {
                    for $BEHLFIDNUMBER in $registrodeRTEResponse/FICORTEType/BEHLFIDNUMBER
                    return
                        <ID_NUMBER>{ data($BEHLFIDNUMBER) }</ID_NUMBER>
                }
                {
                    for $BEHLFFULLNAME in $registrodeRTEResponse/FICORTEType/BEHLFFULLNAME
                    return
                        <FULL_NAME>{ data($BEHLFFULLNAME) }</FULL_NAME>
                }
                {
                    for $BEHLFGENDER in $registrodeRTEResponse/FICORTEType/BEHLFGENDER
                    return
                        <GENDER>{ data($BEHLFGENDER) }</GENDER>
                }
                {
                    for $BEHLFCOUNTRY in $registrodeRTEResponse/FICORTEType/BEHLFCOUNTRY
                    return
                        <COUNTRY>{ data($BEHLFCOUNTRY) }</COUNTRY>
                }
                {
                    for $BEHLFNATIONALITY in $registrodeRTEResponse/FICORTEType/BEHLFNATIONALITY
                    return
                        <NATIONALITY>{ data($BEHLFNATIONALITY) }</NATIONALITY>
                }
                {
                    for $BEHLFDEPARTMENT in $registrodeRTEResponse/FICORTEType/BEHLFDEPARTMENT
                    return
                        <DEPARTMENT>{ data($BEHLFDEPARTMENT) }</DEPARTMENT>
                }
                {
                    for $BEHLFMUNICIPALITY in $registrodeRTEResponse/FICORTEType/BEHLFMUNICIPALITY
                    return
                        <MUNICIPALITY>{ data($BEHLFMUNICIPALITY) }</MUNICIPALITY>
                }
                {
                    for $BEHLFFULLADDRESS in $registrodeRTEResponse/FICORTEType/BEHLFFULLADDRESS
                    return
                        <FULL_ADDRESS>{ data($BEHLFFULLADDRESS) }</FULL_ADDRESS>
                }
                {
                    for $BEHLFTELEPHONE in $registrodeRTEResponse/FICORTEType/BEHLFTELEPHONE
                    return
                        <TELEPHONE>{ data($BEHLFTELEPHONE) }</TELEPHONE>
                }
                {
                    for $BEHLFPROFESSION in $registrodeRTEResponse/FICORTEType/BEHLFPROFESSION
                    return
                        <PROFESSION>{ data($BEHLFPROFESSION) }</PROFESSION>
                }
                {
                    for $BEHLFECONOACT in $registrodeRTEResponse/FICORTEType/BEHLFECONOACT
                    return
                        <ECONO_ACT>{ data($BEHLFECONOACT) }</ECONO_ACT>
                }
                {
                    for $BEHLFBENRELATN in $registrodeRTEResponse/FICORTEType/BEHLFBENRELATN
                    return
                        <BEN_RELATN>{ data($BEHLFBENRELATN) }</BEN_RELATN>
                }
                {
                    for $BEHLFREGNUM in $registrodeRTEResponse/FICORTEType/BEHLFREGNUM
                    return
                        <REG_NUM>{ data($BEHLFREGNUM) }</REG_NUM>
                }
            </RTE_BEHALF_CLIENT>
            <RTE_BEN_CLIENT>
                {
                    for $BENTYPEID in $registrodeRTEResponse/FICORTEType/BENTYPEID
                    return
                        <TYPE_ID>{ data($BENTYPEID) }</TYPE_ID>
                }
                {
                    for $BENIDNUMBER in $registrodeRTEResponse/FICORTEType/BENIDNUMBER
                    return
                        <ID_NUMBER>{ data($BENIDNUMBER) }</ID_NUMBER>
                }
                {
                    for $BENFULLNAME in $registrodeRTEResponse/FICORTEType/BENFULLNAME
                    return
                        <FULL_NAME>{ data($BENFULLNAME) }</FULL_NAME>
                }
                {
                    for $BENGENDER in $registrodeRTEResponse/FICORTEType/BENGENDER
                    return
                        <GENDER>{ data($BENGENDER) }</GENDER>
                }
                {
                    for $BENCOUNTRY in $registrodeRTEResponse/FICORTEType/BENCOUNTRY
                    return
                        <COUNTRY>{ data($BENCOUNTRY) }</COUNTRY>
                }
                {
                    for $BENNATIONALITY in $registrodeRTEResponse/FICORTEType/BENNATIONALITY
                    return
                        <NATIONALITY>{ data($BENNATIONALITY) }</NATIONALITY>
                }
                {
                    for $BENDEPARTMENT in $registrodeRTEResponse/FICORTEType/BENDEPARTMENT
                    return
                        <DEPARTMENT>{ data($BENDEPARTMENT) }</DEPARTMENT>
                }
                {
                    for $BENMUNICIPALITY in $registrodeRTEResponse/FICORTEType/BENMUNICIPALITY
                    return
                        <MUNICIPALITY>{ data($BENMUNICIPALITY) }</MUNICIPALITY>
                }
                {
                    for $BENFULLADDRESS in $registrodeRTEResponse/FICORTEType/BENFULLADDRESS
                    return
                        <FULL_ADDRESS>{ data($BENFULLADDRESS) }</FULL_ADDRESS>
                }
                {
                    for $TELEPHONE in $registrodeRTEResponse/FICORTEType/TELEPHONE
                    return
                        <TELEPHONE>{ data($TELEPHONE) }</TELEPHONE>
                }
                {
                    for $BENPROFESSION in $registrodeRTEResponse/FICORTEType/BENPROFESSION
                    return
                        <PROFESSION>{ data($BENPROFESSION) }</PROFESSION>
                }
                {
                    for $ECONOMICACTIVITY in $registrodeRTEResponse/FICORTEType/ECONOMICACTIVITY
                    return
                        <ECONOMIC_ACTIVITY>{ data($ECONOMICACTIVITY) }</ECONOMIC_ACTIVITY>
                }
            </RTE_BEN_CLIENT>
        </ns0:registrarRTEResponse>
};

declare variable $registrodeRTEResponse as element(ns1:RegistrodeRTEResponse) external;

xf:RegistrarRTEOut($registrodeRTEResponse)