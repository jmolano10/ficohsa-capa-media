(:: pragma bea:global-element-parameter parameter="$depositodechequedegerencia" element="ns0:Depositodechequedegerencia" location="../../xsds/DepositoChequeGerencia/DepositoChequeGerencia.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Depositodechequedegerencia" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/DepositoChequeGerenciaIn/";

declare function xf:DepositoChequeGerenciaIn($depositodechequedegerencia as element(ns0:Depositodechequedegerencia))
    as element(ns0:Depositodechequedegerencia) {
        $depositodechequedegerencia
};

declare variable $depositodechequedegerencia as element(ns0:Depositodechequedegerencia) external;

xf:DepositoChequeGerenciaIn($depositodechequedegerencia)