package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcController;
   import com.robot.core.npc.NpcDialog;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10919 extends BaseMapProcess
   {
      
      private var _conLevel:DisplayObjectContainer;
      
      public function MapProcess_10919()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         (this.conLevel["helka"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onClickNpc);
         (this.conLevel["helka"] as MovieClip).buttonMode = true;
         this._conLevel = super.conLevel;
         this._conLevel["helka"].visible = false;
         this.playAnimation();
      }
      
      private function onClickNpc(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.HEERKA,["终于醒来了！"],["哇哇！你醒啦！刚刚被奇异能量影响，我们都看到你英勇献身的历史啦！"],[function():void
         {
            NpcDialog.show(NPC.HEERKA,["我还没死呢……"],["不过你用身体阻止武器发射后，又发生了什么呢？"],[function():void
            {
               NpcDialog.show(NPC.HEERKA,["当时我身体受到巨大创伤，用最后的能量封印了奥古斯特博士。"],["那后来的守护神是怎么回事呢？"],[function():void
               {
                  NpcDialog.show(NPC.HEERKA,["为了更好保护赫尔卡星，我封印了赫尔卡星的真实面貌，同时还找到他们帮我守护赫尔卡星！"],["555……你太让我感动了。"],[function():void
                  {
                     NpcDialog.show(NPC.HEERKA,["对了，我在赫尔卡星埋下了宝藏哦！里面有很多很多好东西！你们去找吧！我要接着去寻找奥古斯特博士，哼，不会放过他的！"],["我们赶快去寻找宝藏提升实力！然后等到赫尔卡找到奥古斯特的时候，去帮助他！"],[function():void
                     {
                        SocketConnection.sendWithCallback(41644,function(param1:SocketEvent):void
                        {
                           (_conLevel["helka"] as MovieClip).mouseChildren = (_conLevel["helka"] as MovieClip).mouseEnabled = (_conLevel["helka"] as MovieClip).buttonMode = false;
                           _conLevel["helka"]["qes"].visible = false;
                           ModuleManager.showAppModule("MysteryOfHelkaMainPanel");
                        },3);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function playAnimation() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         NpcController.npcVisible = false;
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         ResourceManager.getResource(ClientConfig.getMapAnimate("MysteryOfHelkaAnamate1"),function(param1:MovieClip):void
         {
            var taskMc:MovieClip = param1;
            LevelManager.topLevel.addChild(taskMc);
            AnimateManager.playMcAnimate(taskMc,1,"mc",function():void
            {
               KTool.showMapAllPlayerAndMonster(true);
               NpcController.npcVisible = true;
               LevelManager.iconLevel.visible = true;
               ToolBarController.panel.show();
               DisplayUtil.removeForParent(taskMc);
               _conLevel["helka"].visible = true;
            });
         });
      }
      
      override public function destroy() : void
      {
         (this.conLevel["helka"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onClickNpc);
         super.destroy();
      }
   }
}

