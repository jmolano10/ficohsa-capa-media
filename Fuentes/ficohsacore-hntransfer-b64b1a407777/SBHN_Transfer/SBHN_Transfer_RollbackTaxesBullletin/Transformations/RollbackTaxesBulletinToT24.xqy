xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../Schemas/ReversarTransacciones.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/user";
(:: import schema at "../../SBHN_Transfer_Commons/Schemas/UserLoginT24.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/transfer/transferTypes";
(:: import schema at "../Schemas/RollbackTaxesBulletinTypes.xsd" ::)

declare variable $input as element() (:: schema-element(ns1:rollbackTaxesBullletin) ::) external;
declare variable $userConnInfo as element() (:: schema-element(ns2:connInfoElement) ::) external;

declare function local:funcRollbackTaxesBulletinToT24($input as element() (:: schema-element(ns1:rollbackTaxesBullletin) ::), 
                                                      $userConnInfo as element() (:: schema-element(ns2:connInfoElement) ::)) 
                                                      as element() (:: schema-element(ns3:rollbackTaxesBulletin) ::) {
    <ns3:rollbackTaxesBulletin>
        <WebRequestCommon>
            <userName>{fn:data($userConnInfo/ns2:username)}</userName>
            <password>{fn:data($userConnInfo/ns2:password)}</password>
             <company></company>
        </WebRequestCommon>
        <FUNDSTRANSFERREFCOLLACTRFREVCOPYType>
            <transactionId>{fn:data($input/TransactionId)}</transactionId>
        </FUNDSTRANSFERREFCOLLACTRFREVCOPYType>
    </ns3:rollbackTaxesBulletin>
};

local:funcRollbackTaxesBulletinToT24($input, $userConnInfo)
