package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.utils.CommonUI;
   import flash.events.MouseEvent;
   
   public class MapProcess_1192 extends BaseMapProcess
   {
      
      public function MapProcess_1192()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.btnLevel.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         CommonUI.addYellowArrow(this.btnLevel["arrowMc"]);
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
         var i:int = 0;
         var event:MouseEvent = param1;
         var str:String = event.target.name;
         if(str.indexOf("petBtn_") != -1)
         {
            i = int(str.replace("petBtn_",""));
            NpcDialogNew_1._HasDanmu = false;
            str = MainManager.actorInfo.nick;
            switch(i)
            {
               case 0:
                  NpcDialogNew_1.show(NPC.KING_MIUSI,[str + "，赤瞳的力量在历练中重生！继承超能传承的我，如今已所向披靡。你敢迎接我无尽的力量吗？"],["我要挑战！","等等就来！","我想去看看元素之祖们！"],[function():void
                  {
                     ModuleManager.showAppModule("MiusiBecomeAKingMainPanel");
                  },null,function():void
                  {
                     MapManager.changeMap(1204);
                  }]);
                  break;
               case 1:
                  NpcDialogNew_1.show(NPC.KING_BULAIKE,[str + ",黑夜的力量让我重新苏醒！对.....不能因为复仇而蒙蔽了自己冷静的双眼和睿智的心灵！快来感受我强大的暗影新王之力！"],["现在就去！","等等就来！","我想去看看元素之祖们！"],[function():void
                  {
                     ModuleManager.showAppModule("BeKingofBlankMainPanel");
                  },null,function():void
                  {
                     MapManager.changeMap(1204);
                  }]);
                  break;
               case 2:
                  NpcDialogNew_1.show(NPC.KING_KAXIUSI,[str + "，被清除诅咒之力的我，反而能更加强烈的感受到宽容坚定的大地之力！让大地元素在我的身上进行全新的传承吧！我就是新的大地之王！全民挑战！不可错过哦！"],["现在就去！","等等就来！","我想去看看元素之祖们！"],[function():void
                  {
                     KTool.changeMapWithCallBack(484,function():void
                     {
                     });
                     ModuleManager.showAppModule("BeKingofCassiusPanel");
                  },null,function():void
                  {
                     MapManager.changeMap(1204);
                  }]);
                  break;
               case 3:
                  NpcDialogNew_1.show(2641,[str + ",战斗的力量在我内心传承，战斗的王者从此诞生。王者苏醒之日，万恶臣服之时。你可敢挑战战斗的王者？"],["现在就去！","等等就来！","我想去看看元素之祖们！"],[function():void
                  {
                     ModuleManager.showAppModule("GaiyaBeKingMainPanel");
                  },null,function():void
                  {
                     MapManager.changeMap(1204);
                  }]);
                  break;
               case 4:
                  ModuleManager.showAppModule("ElectricalKingPanel");
            }
         }
      }
      
      override public function destroy() : void
      {
         CommonUI.removeYellowArrow(this.btnLevel);
         NpcDialogNew_1._HasDanmu = true;
         this.btnLevel.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         super.destroy();
      }
   }
}

