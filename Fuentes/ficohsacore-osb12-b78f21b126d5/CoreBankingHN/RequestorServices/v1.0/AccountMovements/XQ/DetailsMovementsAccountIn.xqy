xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/accountMovements";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/getAccountMovementsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DetailsMovementsAccount";
(:: import schema at "../../../../ProviderServices/XSD/DetailsMovementsAccount/DetailsMovementsAccount_sp.xsd" ::)

declare variable $GetAccountMovementsRequest as element() (:: schema-element(ns1:getAccountMovementsRequest) ::) external;
declare variable $fechaT24 as xs:string external;
declare variable $CuentaAbanks as xs:string external;
declare variable $ticketOSB as xs:string external;
declare variable $nombreCuenta as xs:string external;
declare variable $monedaCuenta as xs:string external;

declare function local:func($GetAccountMovementsRequest as element() (:: schema-element(ns1:getAccountMovementsRequest) ::), 
                            $fechaT24 as xs:string, 
                            $CuentaAbanks as xs:string, 
                            $ticketOSB as xs:string, 
                            $nombreCuenta as xs:string, 
                            $monedaCuenta as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_ACCOUNTNUMBER>{fn:data($CuentaAbanks)}</ns2:PV_ACCOUNTNUMBER>
        <ns2:PV_BEGINDATE>{fn:data($GetAccountMovementsRequest/BeginDate)}</ns2:PV_BEGINDATE>
        <ns2:PV_ENDDATE>
        {
          if ($fechaT24 != "") then
            ($fechaT24)
          else 
            fn:data($GetAccountMovementsRequest/EndDate)
        }
        </ns2:PV_ENDDATE>
        <ns2:PN_INITIALRECORD>{fn:data($GetAccountMovementsRequest/PagingInfo/InitialRecord)}</ns2:PN_INITIALRECORD>
        <ns2:PN_RECORDCOUNT>{fn:data($GetAccountMovementsRequest/PagingInfo/RecordCount)}</ns2:PN_RECORDCOUNT>
        <ns2:PV_TICKETOSB>{fn:data($ticketOSB)}</ns2:PV_TICKETOSB>
        <ns2:PT_TYPEFILTER>
        {
          for $FILTER_CRITERIA in $GetAccountMovementsRequest/FilterCriterias/filterCriteria
          return
            for $TYPE_FILTER in $FILTER_CRITERIA/TypeFilter
            return
              <ns2:PT_TYPEFILTER_ITEM>{ data($TYPE_FILTER) }</ns2:PT_TYPEFILTER_ITEM>
        }
        </ns2:PT_TYPEFILTER>
        <ns2:PT_VALUEFILTER>
        { 
          for $FILTER_CRITERIA in $GetAccountMovementsRequest/FilterCriterias/filterCriteria
          return
            for $VALUE_FILTER in $FILTER_CRITERIA/ValueFilter
            return
              <ns2:PT_TYPEFILTER_ITEM>{ data($VALUE_FILTER) }</ns2:PT_TYPEFILTER_ITEM>
	}
        </ns2:PT_VALUEFILTER>
        <ns2:PV_ACCOUNTNAME>{fn:data($nombreCuenta)}</ns2:PV_ACCOUNTNAME>
        <ns2:PV_CURRENCY>{fn:data($monedaCuenta)}</ns2:PV_CURRENCY>
    </ns2:InputParameters>
};

local:func($GetAccountMovementsRequest, $fechaT24, $CuentaAbanks, $ticketOSB, $nombreCuenta, $monedaCuenta)