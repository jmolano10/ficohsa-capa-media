(:: pragma bea:global-element-parameter parameter="$consultaCargosRecurrentesDiarios" element="ns1:consultaCargosRecurrentesDiarios" location="../xsd/consultaCargosRecurrentesDiariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:QueryCardTransaction" location="../../../BusinessServices/VisaNet/wsdl/WSVisaTransaction.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesDiariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargosRecurrentesDiarios/queryCardTransactionIn/";

declare function xf:queryCardTransactionIn($idStrUser as xs:string,
    $idStrPassword as xs:string,
    $idStrCardacqMatrizId as xs:string,
    $idStrTerminalMatrizId as xs:string,
    $consultaCargosRecurrentesDiarios as element(ns1:consultaCargosRecurrentesDiarios))
    as element(ns0:QueryCardTransaction) {
        <ns0:QueryCardTransaction>
            <ns0:input>
                <ns0:strUser>{ $idStrUser }</ns0:strUser>
                <ns0:strPassword>{ $idStrPassword }</ns0:strPassword>
                <ns0:strCardacqMatrizId>{ $idStrCardacqMatrizId }</ns0:strCardacqMatrizId>
                <ns0:strTerminalMatrizId>{ $idStrTerminalMatrizId }</ns0:strTerminalMatrizId>
                <ns0:strCardNumber>{ xs:long(data($consultaCargosRecurrentesDiarios/CARD_NUMBER)) }</ns0:strCardNumber>
                <ns0:strDateIn>{fn-bea:date-to-string-with-format("yyyy-MM-dd", current-date()) }</ns0:strDateIn>
                <ns0:strDateOut>{fn-bea:date-to-string-with-format("yyyy-MM-dd",current-date()) }</ns0:strDateOut>
            </ns0:input>
        </ns0:QueryCardTransaction>
};

declare variable $idStrUser as xs:string external;
declare variable $idStrPassword as xs:string external;
declare variable $idStrCardacqMatrizId as xs:string external;
declare variable $idStrTerminalMatrizId as xs:string external;
declare variable $consultaCargosRecurrentesDiarios as element(ns1:consultaCargosRecurrentesDiarios) external;

xf:queryCardTransactionIn($idStrUser,
    $idStrPassword,
    $idStrCardacqMatrizId,
    $idStrTerminalMatrizId,
    $consultaCargosRecurrentesDiarios)