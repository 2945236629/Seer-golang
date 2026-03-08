package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcess_11564 extends BaseMapProcess
   {
      
      private var curIndex:int = 1;
      
      private var itemNum:int = 0;
      
      public function MapProcess_11564()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         LevelManager.toolsLevel.visible = false;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.updatePanel();
         StatManager.sendStat2014("1110VIP全民放送","打开场景UI","2017运营活动");
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var index:int = 0;
         var e:MouseEvent = param1;
         index = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "fight_" + index:
               FightManager.fightNoMapBoss(["元气鼠","克拉瑞斯","弗斯特"][index - 1],11260 + index,false,true,function():void
               {
                  if(FightManager.isWin)
                  {
                     if(index == curIndex)
                     {
                        Alarm.show("你成功抓住了破坏会场的捣蛋鬼！");
                     }
                     else
                     {
                        Alarm.show("你没有抓住真正的捣蛋鬼，仔细研读给出的线索。请再试1次吧！");
                     }
                  }
               });
               break;
            case "btn_" + index:
               StatManager.sendStat2014("1110VIP全民放送",["点击场景内的地洞","点击场景内的碎冰","点击场景内的屏幕"][index - 1],"2017运营活动");
               this.curIndex = index;
               this.showTipsPanel(index);
               break;
            case "onekey":
               ModuleManager.showAppModule("MultiBuyPanel",{
                  "productID":252007,
                  "iconID":1715069,
                  "exchangeID":10855,
                  "callFunction":function(param1:int):void
                  {
                     updatePanel();
                  }
               });
               break;
            case "plus":
               ModuleManager.showAppModule("MultiBuyPanel",{
                  "productID":252007,
                  "iconID":1715069,
                  "exchangeID":10855,
                  "callFunction":function(param1:int):void
                  {
                     showTipsPanel();
                  }
               });
               break;
            case "start":
               if(this.itemNum > 0)
               {
                  KTool.doExchange(10857 + this.curIndex,function():void
                  {
                     conLevel["tipsPanel"].visible = false;
                     AnimateManager.playMcAnimate(conLevel["mc"],2,"mc",updatePanel);
                  });
                  break;
               }
               Alarm.show("你目前没有棉花糖啦，可以明天找薇薇领取或者快速购买来获得。");
               break;
            case "close":
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("VIPEightYearAllPeopleGetMainPanel");
               });
               break;
            case "subClose":
               this.updatePanel();
               break;
            case "bag":
               ModuleManager.showAppModule("ADPetBagPanelNew");
               break;
            case "cure":
               PetManager.cureAllFree();
         }
      }
      
      public function updatePanel() : void
      {
         conLevel["tipsPanel"].visible = false;
         KTool.getMultiValue([6981],function(param1:Array):void
         {
            var value:Array = param1;
            curIndex = value[0] & 7;
            curIndex = curIndex == 1 ? 1 : (curIndex == 2 ? 2 : (curIndex == 4 ? 3 : 0));
            ItemManager.updateAndGetItemsNum([1715069],function(param1:Array):void
            {
               var item:Array = param1;
               itemNum = item[0];
               conLevel["txt_1"].text = item[0];
               if(curIndex > 0)
               {
                  conLevel["mc"].gotoAndStop(2);
                  MovieClip(conLevel["mc"]).addEventListener(Event.FRAME_CONSTRUCTED,function(param1:Event):void
                  {
                     param1.currentTarget.removeEventListener(Event.FRAME_CONSTRUCTED,arguments.callee);
                     conLevel["mc"]["mc"].gotoAndStop(133);
                  });
               }
               else
               {
                  conLevel["mc"].gotoAndStop(1);
               }
            });
         });
      }
      
      public function showTipsPanel(param1:int = 1) : void
      {
         var index:int = param1;
         conLevel["tipsPanel"].visible = true;
         conLevel["tipsPanel"]["mc"].gotoAndStop(index);
         ItemManager.updateAndGetItemsNum([1715069],function(param1:Array):void
         {
            itemNum = param1[0];
            conLevel["tipsPanel"]["txt_1"].text = param1[0];
         });
      }
      
      override public function destroy() : void
      {
         KTool.showMapAllPlayerAndMonster();
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         LevelManager.toolsLevel.visible = true;
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         super.destroy();
      }
   }
}

