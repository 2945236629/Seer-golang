package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   
   public class MapProcess_11475 extends BaseMapProcess
   {
      
      private var dialogBaiBaiArr:Array = ["不要看我，礼包好像在克里斯身上。","克里斯在忽悠你，不要听他的！","礼包不在我这里，我对天发誓。","孙小圣在忽悠你，不要听他的！"];
      
      private var dialogKeLiSiArr:Array = ["我记得礼包是由孙小圣带着的。","不要看我，礼包好像在白白身上。","不要看我，礼包好像在伊力沙身上。","礼包不在我这里，我对天发誓。"];
      
      private var dialogYiLiShaArr:Array = ["礼包不在我这里，我对天发誓。","我记得礼包是由克里斯带着的。","我记得礼包是由孙小圣带着的。","不要看我，礼包好像在孙小圣身上。"];
      
      private var dialogSunXiaoShenArr:Array = ["克里斯在忽悠你，不要听他的！","礼包不在我这里，我对天发誓。","伊力沙在忽悠你，不要听他的！","我记得礼包是由白白带着的。"];
      
      private var _index:int;
      
      public function MapProcess_11475()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["BaiBai"],this.onClick);
         MapListenerManager.add(conLevel["KeLiSi"],this.onClick);
         MapListenerManager.add(conLevel["YiLiSha"],this.onClick);
         MapListenerManager.add(conLevel["SunXiaoShen"],this.onClick);
         KTool.getMultiValue([18179],function(param1:Array):void
         {
            _index = param1[0];
         });
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var ename:String = e.target.name;
         switch(ename)
         {
            case "BaiBai":
               NpcDialogNew_1.show(NPC.BAIBAI,[this.dialogBaiBaiArr[this._index - 1]],["礼包一定在你的身上！","让我再想想。"],[function():void
               {
                  challenge(1);
               }]);
               break;
            case "KeLiSi":
               NpcDialogNew_1.show(NPC.KELISI,[this.dialogKeLiSiArr[this._index - 1]],["礼包一定在你的身上！","让我再想想。"],[function():void
               {
                  challenge(2);
               }]);
               break;
            case "YiLiSha":
               NpcDialogNew_1.show(NPC.YILISHA,[this.dialogYiLiShaArr[this._index - 1]],["礼包一定在你的身上！","让我再想想。"],[function():void
               {
                  challenge(3);
               }]);
               break;
            case "SunXiaoShen":
               NpcDialogNew_1.show(NPC.SUNXIAOSHENG,[this.dialogSunXiaoShenArr[this._index - 1]],["礼包一定在你的身上！","让我再想想。"],[function():void
               {
                  challenge(4);
               }]);
         }
      }
      
      private function challenge(param1:int) : void
      {
         var arr:Array = null;
         var i:int = param1;
         arr = [3,4,1,2];
         FightManager.fightNoMapBoss("",9166 + i - 1,false,true,function():void
         {
            if(FightManager.isWin)
            {
               if(arr[_index - 1] == i)
               {
                  MapManager.changeMapWithCallback(1,function():void
                  {
                     ModuleManager.showAppModule("SchoolOpenGiftPanel");
                  });
               }
               else
               {
                  Alarm.show("很遗憾，你并没有在他的身上发现礼包！");
               }
            }
         });
      }
   }
}

