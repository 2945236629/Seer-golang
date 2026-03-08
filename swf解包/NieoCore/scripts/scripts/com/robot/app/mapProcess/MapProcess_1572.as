package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.CommonUI;
   import flash.events.MouseEvent;
   
   public class MapProcess_1572 extends BaseMapProcess
   {
      
      private var apps:Array = ["BranchLineTask0930MainPanel","JiuLiNaOfStoneShopMainPanel","JNBZZLGMainPanel","ComeAdventureForTreasureMainPanel","RewardRegistrationOfTreasureHunterMainPanel","BattleReadinessCenterOfJetlowMainPanel"];
      
      public function MapProcess_1572()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         while(i < 6)
         {
            conLevel["btn_" + i].addEventListener(MouseEvent.CLICK,this.clickHandle);
            i++;
         }
         KTool.getMultiValue([123523],function(param1:Array):void
         {
            if(conLevel)
            {
               CommonUI.setEnabled2(conLevel["btn_0"],(param1[0] & 0x0F) < 9,false);
            }
         });
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = parseInt(_loc2_.split("_")[1]);
         switch(_loc3_)
         {
            case 0:
               ModuleManager.showAppModule(this.apps[_loc3_]);
               _loc4_ = 0;
               while(_loc4_ < 6)
               {
                  conLevel["btn_" + _loc4_].visible = true;
                  _loc4_++;
               }
               if(BitBuffSetClass.getState(24201) == 0)
               {
                  BitBuffSetClass.setState(24201,1);
               }
               break;
            default:
               ModuleManager.showAppModule(this.apps[_loc3_]);
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            conLevel["btn_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.clickHandle);
            _loc1_++;
         }
         super.destroy();
      }
   }
}

