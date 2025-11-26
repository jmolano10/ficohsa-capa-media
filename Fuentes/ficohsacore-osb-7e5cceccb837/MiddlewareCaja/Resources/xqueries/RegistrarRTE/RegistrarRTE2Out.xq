(:: pragma bea:global-element-parameter parameter="$consultadedetalleRTEResponse" element="ns1:ConsultadedetalleRTEResponse" location="../../xsds/RegistroRTE/XMLSchema_-102414330.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registrarRTEResponse" location="../../xsds/RegistrarRTE/RegistrarRTE.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/RegistrarRTE2Out/";

declare function xf:RegistrarRTE2Out($consultadedetalleRTEResponse as element(ns1:ConsultadedetalleRTEResponse),
    $inputter as xs:string,
    $authoriser as xs:string,
    $branchName as xs:string,
    $datetime as xs:string,
    $transactionName as xs:string)
    as element(ns0:registrarRTEResponse) {
        <ns0:registrarRTEResponse>
            {
                for $TRANSACTIONDATE in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/TRANSACTIONDATE
                return
                    <DATE>{ data($TRANSACTIONDATE) }</DATE>
            }
            {
                for $TRANSACTIONTIME in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/TRANSACTIONTIME
                return
                    <HOUR>{ data($TRANSACTIONTIME) }</HOUR>
            }
            {
                for $TRANSACTIONID in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/TRANSACTIONID
                return
                    <TELLER_TXN_NO>{ data($TRANSACTIONID) }</TELLER_TXN_NO>
            }
            <TRANSACTION_TYPE>{ $transactionName }</TRANSACTION_TYPE>
            {
                for $TXNCURRENCY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/TXNCURRENCY
                return
                    <CURRENCY>{ data($TXNCURRENCY) }</CURRENCY>
            }
            {
                for $TXNAMOUNT in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/TXNAMOUNT
                return
                    <AMOUNT>{ data($TXNAMOUNT) }</AMOUNT>
            }
            {
                for $EXCHANGERATE in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/EXCHANGERATE
                return
                    <EXCHANGE_RATE>{ data($EXCHANGERATE) }</EXCHANGE_RATE>
            }
            {
                for $BRANCHID in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BRANCHID
                return
                    <BRANCH_ID>{ data($BRANCHID) }</BRANCH_ID>
            }
            {
                for $ACCOUNT in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ACCOUNT
                return
                    <AFFECTED_ACCOUNT>{ data($ACCOUNT) }</AFFECTED_ACCOUNT>
            }
            {
                for $TXNOWNER in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/TXNOWNER
                return
                    <OWNER_TXN>{ data($TXNOWNER) }</OWNER_TXN>
            }
            <RTE_AGENCY>{ $branchName }</RTE_AGENCY>
            <INPUTTER>{ $inputter }</INPUTTER>
            <DATETIME>{ concat("20", $datetime) }</DATETIME>
            <AUTHORISER>{ $authoriser }</AUTHORISER>
            {
                for $BRANCHID in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BRANCHID
                return
                    <CO_CODE>{ data($BRANCHID) }</CO_CODE>
            }
            <RTE_CLIENT>
                {
                    for $ATYPEID in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ATYPEID
                    return
                        <TYPE_ID>{ data($ATYPEID) }</TYPE_ID>
                }
                {
                    for $AIDNUMBER in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/AIDNUMBER
                    return
                        <ID_NUMBER>{ data($AIDNUMBER) }</ID_NUMBER>
                }
                {
                    for $AFULLNAME in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/AFULLNAME
                    return
                        <FULL_NAME>{ data($AFULLNAME) }</FULL_NAME>
                }
                {
                    for $ABIRTHDATE in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ABIRTHDATE
                    return
                        <DATE_OF_BIRTH>{ data($ABIRTHDATE) }</DATE_OF_BIRTH>
                }
                {
                    for $AGENDER in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/AGENDER
                    return
                        <GENDER>{ data($AGENDER) }</GENDER>
                }
                {
                    for $ACOUNTRY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ACOUNTRY
                    return
                        <COUNTRY>{ data($ACOUNTRY) }</COUNTRY>
                }
                {
                    for $ANATIONALITY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ANATIONALITY
                    return
                        <NATIONALITY>{ data($ANATIONALITY) }</NATIONALITY>
                }
                {
                    for $ADEPARTMENT in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ADEPARTMENT
                    return
                        <DEPARTMENT>{ data($ADEPARTMENT) }</DEPARTMENT>
                }
                {
                    for $AMUNICIPALITY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/AMUNICIPALITY
                    return
                        <MUNICIPALITY>{ data($AMUNICIPALITY) }</MUNICIPALITY>
                }
                {
                    for $AHOMEADDRESS in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/AHOMEADDRESS
                    return
                        <HOME_ADDRESS>{ data($AHOMEADDRESS) }</HOME_ADDRESS>
                }
                {
                    for $ARESIDENCENUMBER in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ARESIDENCENUMBER
                    return
                        <RESIDENCE_NUMBER>{ data($ARESIDENCENUMBER) }</RESIDENCE_NUMBER>
                }
                {
                    for $APROFESSION in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/APROFESSION
                    return
                        <PROFESSION>{ data($APROFESSION) }</PROFESSION>
                }
                {
                    for $ACOMPANYNAME in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ACOMPANYNAME
                    return
                        <COMPANY_NAME>{ data($ACOMPANYNAME) }</COMPANY_NAME>
                }
                {
                    for $AWORKPHONE in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/AWORKPHONE
                    return
                        <WORK_PHONE>{ data($AWORKPHONE) }</WORK_PHONE>
                }
                {
                    for $ABENEFREL in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/ABENEFREL
                    return
                        <BENE_RELATION>{ data($ABENEFREL) }</BENE_RELATION>
                }
            </RTE_CLIENT>
            <RTE_BEHALF_CLIENT>
                {
                    for $BTYPEID in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BTYPEID
                    return
                        <TYPE_ID>{ data($BTYPEID) }</TYPE_ID>
                }
                {
                    for $BIDNUMBER in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BIDNUMBER
                    return
                        <ID_NUMBER>{ data($BIDNUMBER) }</ID_NUMBER>
                }
                {
                    for $BFULLNAME in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BFULLNAME
                    return
                        <FULL_NAME>{ data($BFULLNAME) }</FULL_NAME>
                }
                {
                    for $BGENDER in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BGENDER
                    return
                        <GENDER>{ data($BGENDER) }</GENDER>
                }
                {
                    for $BCOUNTRY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BCOUNTRY
                    return
                        <COUNTRY>{ data($BCOUNTRY) }</COUNTRY>
                }
                {
                    for $BNATIONALITY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BNATIONALITY
                    return
                        <NATIONALITY>{ data($BNATIONALITY) }</NATIONALITY>
                }
                {
                    for $BDEPARTMENT in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BDEPARTMENT
                    return
                        <DEPARTMENT>{ data($BDEPARTMENT) }</DEPARTMENT>
                }
                {
                    for $BMUNICIPALITY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BMUNICIPALITY
                    return
                        <MUNICIPALITY>{ data($BMUNICIPALITY) }</MUNICIPALITY>
                }
                {
                    for $BFULLADDRESS in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BFULLADDRESS
                    return
                        <FULL_ADDRESS>{ data($BFULLADDRESS) }</FULL_ADDRESS>
                }
                {
                    for $BTELEPHONE in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BTELEPHONE
                    return
                        <TELEPHONE>{ data($BTELEPHONE) }</TELEPHONE>
                }
                {
                    for $BPROFESSION in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BPROFESSION
                    return
                        <PROFESSION>{ data($BPROFESSION) }</PROFESSION>
                }
                {
                    for $BECONOMICACT in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BECONOMICACT
                    return
                        <ECONO_ACT>{ data($BECONOMICACT) }</ECONO_ACT>
                }
                {
                    for $BBENEFREL in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/BBENEFREL
                    return
                        <BEN_RELATN>{ data($BBENEFREL) }</BEN_RELATN>
                }
            </RTE_BEHALF_CLIENT>
            <RTE_BEN_CLIENT>
                {
                    for $CTYPEID in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CTYPEID
                    return
                        <TYPE_ID>{ data($CTYPEID) }</TYPE_ID>
                }
                {
                    for $CIDNUMBER in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CIDNUMBER
                    return
                        <ID_NUMBER>{ data($CIDNUMBER) }</ID_NUMBER>
                }
                {
                    for $CFULLNAME in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CFULLNAME
                    return
                        <FULL_NAME>{ data($CFULLNAME) }</FULL_NAME>
                }
                {
                    for $CGENDER in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CGENDER
                    return
                        <GENDER>{ data($CGENDER) }</GENDER>
                }
                {
                    for $CCOUNTRY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CCOUNTRY
                    return
                        <COUNTRY>{ data($CCOUNTRY) }</COUNTRY>
                }
                {
                    for $CNATIONALITY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CNATIONALITY
                    return
                        <NATIONALITY>{ data($CNATIONALITY) }</NATIONALITY>
                }
                {
                    for $CDEPARTMENT in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CDEPARTMENT
                    return
                        <DEPARTMENT>{ data($CDEPARTMENT) }</DEPARTMENT>
                }
                {
                    for $CMUNICIPALITY in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CMUNICIPALITY
                    return
                        <MUNICIPALITY>{ data($CMUNICIPALITY) }</MUNICIPALITY>
                }
                {
                    for $CFULLADDRESS in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CFULLADDRESS
                    return
                        <FULL_ADDRESS>{ data($CFULLADDRESS) }</FULL_ADDRESS>
                }
                {
                    for $CWORKPHONE in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CWORKPHONE
                    return
                        <TELEPHONE>{ data($CWORKPHONE) }</TELEPHONE>
                }
                {
                    for $CPROFESSION in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CPROFESSION
                    return
                        <PROFESSION>{ data($CPROFESSION) }</PROFESSION>
                }
                {
                    for $CECONOMICACT in $consultadedetalleRTEResponse/WSFICORTEENQType[1]/gWSFICORTEENQDetailType/mWSFICORTEENQDetailType[1]/CECONOMICACT
                    return
                        <ECONOMIC_ACTIVITY>{ data($CECONOMICACT) }</ECONOMIC_ACTIVITY>
                }
            </RTE_BEN_CLIENT>
        </ns0:registrarRTEResponse>
};

declare variable $consultadedetalleRTEResponse as element(ns1:ConsultadedetalleRTEResponse) external;
declare variable $inputter as xs:string external;
declare variable $authoriser as xs:string external;
declare variable $branchName as xs:string external;
declare variable $datetime as xs:string external;
declare variable $transactionName as xs:string external;

xf:RegistrarRTE2Out($consultadedetalleRTEResponse,
    $inputter,
    $authoriser,
    $branchName,
    $datetime,
    $transactionName)