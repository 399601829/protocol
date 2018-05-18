/*

  Copyright 2017 Loopring Project Ltd (Loopring Foundation).

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/
pragma solidity 0.4.23;
pragma experimental "v0.5.0";
pragma experimental "ABIEncoderV2";


import "./Data.sol";
import "./lib/MathUint.sol";

/// @title ParticipationUtil
/// @author Daniel Wang - <daniel@loopring.org>.
library ParticipationUtil {
    using MathUint      for uint;

    function updateFillAmounts(
        Data.Participation p
        )
        public
        pure
        returns (bool isSmaller)
    {
        Data.Order memory order = p.order;

        p.fillAmountB = p.fillAmountS.mul(p.rateB) / p.rateS;

        if (order.capByAmountB) {
            if (p.fillAmountB > order.maxAmountB) {
                p.fillAmountB = order.maxAmountB;
                p.fillAmountS = p.fillAmountB.mul(p.rateS) / p.rateB;
                isSmaller = true;
            }
            p.lrcFee = order.lrcFee.mul(p.fillAmountB) / order.amountB;
        } else {
            p.lrcFee = order.lrcFee.mul(p.fillAmountS) / order.amountS;
        }
    }

    function updateFeeAmounts(
        Data.Participation p
        )
        public
        pure
    {
        Data.Order memory order = p.order;

    }
}