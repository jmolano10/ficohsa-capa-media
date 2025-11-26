xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/ContractsAgreements/ContractsAgreements.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/collectionContractDetailTypes";
(:: import schema at "../XSD/collectionContractDetailTypes.xsd" ::)

declare variable $ContractsAgreementsResponse as element() (:: schema-element(ns1:ConsultadetallecontratorecaudoResponse) ::) external;

declare function local:func($ContractsAgreementsResponse as element() (:: schema-element(ns1:ConsultadetallecontratorecaudoResponse) ::)) as element() (:: schema-element(ns2:CollectionContractDetailResponse) ::) {
    <ns2:CollectionContractDetailResponse>
        <ns2:ResponseCode>{fn:data($ContractsAgreementsResponse/Status/successIndicator)}</ns2:ResponseCode>
        {
          let $result :=
                    for $messages in $ContractsAgreementsResponse/Status/messages
                    return
                        <ns2:ResponseMessage>{ data($messages) }</ns2:ResponseMessage>
                return
                    $result[1]
        }
        {
          for $gWSCOLLECTIONCONDSDetailType in $ContractsAgreementsResponse/WSCOLLECTIONCONDSType[1]/gWSCOLLECTIONCONDSDetailType
          return
              <ns2:CollectionContractDetailResponseType>
              {
                  for $mWSCOLLECTIONCONDSDetailType in $gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType
                  return
                      <ns2:CollectionContractDetailResponseRecordType>
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/ID)
                          then <ns2:ContractId>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/ID)}</ns2:ContractId>
                          else ()
                      }
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/DESCRIPTION)
                          then <ns2:ContractName>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/DESCRIPTION)}</ns2:ContractName>
                          else ()
                      }
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/CUSTOMERNO)
                          then <ns2:CustomerId>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/CUSTOMERNO)}</ns2:CustomerId>
                          else ()
                      }
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/INFOEXCHANGETYPE)
                          then <ns2:InfoExchangeType>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/INFOEXCHANGETYPE)}</ns2:InfoExchangeType>
                          else ()
                      }
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/COLLECTIONTYPE)
                          then <ns2:CollectionType>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/COLLECTIONTYPE)}</ns2:CollectionType>
                          else ()
                      }
                      <ns2:AllowedBranches>
                          {
                              for $ALLOWEDBRANCHE in fn:tokenize($mWSCOLLECTIONCONDSDetailType/ALLOWEDBRANCHES, "\|\|")
                              return
                                  if(fn:string($ALLOWEDBRANCHE) != "") then (
                                    <BranchCode>{ $ALLOWEDBRANCHE }</BranchCode>
                                  ) else ()
                          }
                      </ns2:AllowedBranches>
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/PAYMENTVALUECHECK)
                          then <ns2:PaymentValueCheck>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/PAYMENTVALUECHECK)}</ns2:PaymentValueCheck>
                          else ()
                      }
                      <ns2:PaymentMethods>
                      {
                              for $PAYMENT_METHOD in fn:tokenize($mWSCOLLECTIONCONDSDetailType/PAYMENTMETHOD, "\|\|")
                              return
                                  if(fn:string($PAYMENT_METHOD) != "") then (
                                    <PaymentMethod>{ $PAYMENT_METHOD }</PaymentMethod>
                                  ) else ()
                      }
                      </ns2:PaymentMethods>
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/PAYOLDBILLFIRST)
                          then <ns2:PayOldBillFirst>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/PAYOLDBILLFIRST)}</ns2:PayOldBillFirst>
                          else ()
                      }
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/DUEDATECHECK)
                          then <ns2:DueDateCheck>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/DUEDATECHECK)}</ns2:DueDateCheck>
                          else ()
                      }
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/PENALTYTYPE)
                          then <ns2:PenaltyType>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/PENALTYTYPE)}</ns2:PenaltyType>
                          else ()
                      }
                      {
                          if ($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/MULTICCYCHECK)
                          then <ns2:MultiCCYCheck>{fn:data($ContractsAgreementsResponse/WSCOLLECTIONCONDSType/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType/MULTICCYCHECK)}</ns2:MultiCCYCheck>
                          else ()
                      }
                      <ns2:ContractType></ns2:ContractType>
                  </ns2:CollectionContractDetailResponseRecordType>
              }
            </ns2:CollectionContractDetailResponseType>
        }
        
    </ns2:CollectionContractDetailResponse>
};

local:func($ContractsAgreementsResponse)